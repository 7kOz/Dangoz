import 'dart:io';

import 'package:dangoz/base/enums/message_enums.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:dangoz/features/chat/providers/message_reply_provider.dart';
import 'package:dangoz/features/chat/repository/chat_repository.dart';
import 'package:dangoz/models/chat_contact_model.dart';
import 'package:dangoz/models/message_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    ref: ref,
    chatRepository: chatRepository,
  );
});

class ChatController {
  final ProviderRef ref;
  final ChatRepository chatRepository;
  ChatController({
    required this.ref,
    required this.chatRepository,
  });

  Stream<UserModel> userDataById(String userUid) {
    return chatRepository.userData(userUid);
  }

  Stream<List<ChatContactModel>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<MessageModel>> chatStream(String recieverId) {
    return chatRepository.getChatStream(recieverId);
  }

  void sendTextMessage(
    String message,
    String recieverUserId,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            message: message,
            recieverUserId: recieverUserId,
            senderUser: value!,
            messageReply: messageReply,
          ),
        );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void sendAttachmentMessage(
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendAttachmentMessage(
              file: file,
              reciverUserId: recieverUserId,
              senderUserData: value!,
              ref: ref,
              messageEnum: messageEnum,
              messageReply: messageReply),
        );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void sendGIFMessage(
    String gifUrl,
    String recieverUserId,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    //Need to edit URL For GIFs to be able to show them
    int gifURLPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifURLPart = gifUrl.substring(gifURLPartIndex);
    String newGIFURL = 'https://i.giphy.com/media/$gifURLPart/200.gif';

    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendGIFMessage(
            gifUrl: newGIFURL,
            recieverUserId: recieverUserId,
            senderUser: value!,
            messageReply: messageReply,
          ),
        );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void setChatMessageToSeen(
    String recieverUserId,
    String messageId,
  ) {
    chatRepository.setChatMessageToSeen(recieverUserId, messageId);
  }
}
