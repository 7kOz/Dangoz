import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/enums/message_enums.dart';
import 'package:dangoz/base/repositories/firebase_storage_repository.dart';
import 'package:dangoz/features/chat/providers/message_reply_provider.dart';
import 'package:dangoz/models/chat_contact_model.dart';
import 'package:dangoz/models/message_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<UserModel> userData(String userUid) {
    return firestore.collection('Users').doc(userUid).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  Stream<List<ChatContactModel>> getChatContacts() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap((event) async {
      List<ChatContactModel> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContactModel.fromMap(document.data());
        var userData = await firestore
            .collection('Users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(
          ChatContactModel(
              name: user.name,
              profileImage: user.profileImage as String,
              contactId: user.uid,
              timeSent: chatContact.timeSent,
              lastMessage: chatContact.lastMessage),
        );
      }
      return contacts;
    });
  }

  Stream<List<MessageModel>> getChatStream(String recieverId) {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .doc(recieverId)
        .collection('Messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }

  void _saveDataToContactsSubCollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String message,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    // Users -> reciever user id -> Chats -> current user id - >  set data
    var recieverChatContact = ChatContactModel(
      name: senderUserData.name,
      profileImage: senderUserData.profileImage!,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: message,
    );
    await firestore
        .collection('Users')
        .doc(recieverUserId)
        .collection('Chats')
        .doc(senderUserData.uid)
        .set(
          recieverChatContact.toMap(),
        );
    // Users -> current user id -> Chats -> reciever user id - >  set data
    var senderChatContact = ChatContactModel(
      name: recieverUserData.name,
      profileImage: recieverUserData.profileImage!,
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: message,
    );
    await firestore
        .collection('Users')
        .doc(senderUserData.uid)
        .collection('Chats')
        .doc(recieverUserData.uid)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubCollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String senderName,
    required String recieverName,
    required MessageEnum messageType,
    required MessageReply? messageReply,
  }) async {
    final message = MessageModel(
      senderId: auth.currentUser!.uid,
      reciverId: recieverUserId,
      message: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderName
              : recieverName,
      repliedMessageType:
          messageReply == null ? MessageEnum.TEXT : messageReply.messageEnum,
    );
    // Users -> sender id  -> reciever id -> messages -> message id -> store message
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .doc(recieverUserId)
        .collection('Messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    // Users -> reciever id  -> sender id -> messages -> message id -> store message
    await firestore
        .collection('Users')
        .doc(recieverUserId)
        .collection('Chats')
        .doc(auth.currentUser!.uid)
        .collection('Messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required String message,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;

      var userDataMap =
          await firestore.collection('Users').doc(recieverUserId).get();

      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      var messageId = const Uuid().v1();
      _saveDataToContactsSubCollection(
        senderUser,
        recieverUserData,
        message,
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubCollection(
        recieverUserId: recieverUserId,
        text: message,
        timeSent: timeSent,
        messageType: MessageEnum.TEXT,
        messageId: messageId,
        recieverName: recieverUserData.name,
        senderName: senderUser.name,
        messageReply: messageReply,
      );
    } catch (e) {
      print(e);
    }
  }

  void sendAttachmentMessage({
    required File file,
    required String reciverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      String attachmentUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'Chats/${messageEnum.type}/${senderUserData.uid}/$reciverUserId/$messageId',
            file,
          );
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('Users').doc(reciverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      String contactMessage;

      switch (messageEnum) {
        case MessageEnum.IMAGE:
          contactMessage = '📷 Image';
          break;
        case MessageEnum.VIDEO:
          contactMessage = '📹 Video';
          break;
        case MessageEnum.AUDIO:
          contactMessage = '🎙 Audio';
          break;
        case MessageEnum.GIF:
          contactMessage = '🐼 GIF';
          break;
        default:
          contactMessage = '🐼 GIF';
      }

      _saveDataToContactsSubCollection(
        senderUserData,
        recieverUserData,
        contactMessage,
        timeSent,
        reciverUserId,
      );

      _saveMessageToMessageSubCollection(
        recieverUserId: reciverUserId,
        text: attachmentUrl,
        timeSent: timeSent,
        messageId: messageId,
        senderName: senderUserData.name,
        recieverName: recieverUserData.name,
        messageType: messageEnum,
        messageReply: messageReply,
      );
    } catch (e) {
      Get.snackbar(
        'Oops',
        e.toString(),
        backgroundColor: AppColors.red,
      );
      //print(e);
    }
  }

  void sendGIFMessage({
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;

      var userDataMap =
          await firestore.collection('Users').doc(recieverUserId).get();

      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      var messageId = const Uuid().v1();
      _saveDataToContactsSubCollection(
        senderUser,
        recieverUserData,
        'GIF',
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubCollection(
        recieverUserId: recieverUserId,
        text: gifUrl,
        timeSent: timeSent,
        messageType: MessageEnum.GIF,
        messageId: messageId,
        recieverName: recieverUserData.name,
        senderName: senderUser.name,
        messageReply: messageReply,
      );
    } catch (e) {
      print(e);
    }
  }

  void setChatMessageToSeen(
    String recieverUserId,
    String messageId,
  ) async {
    try {
      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .collection('Chats')
          .doc(recieverUserId)
          .collection('Messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });
      await firestore
          .collection('Users')
          .doc(recieverUserId)
          .collection('Chats')
          .doc(auth.currentUser!.uid)
          .collection('Messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });
    } catch (e) {
      print(e);
    }
  }
}
