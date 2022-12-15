import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/enums/message_enums.dart';
import 'package:dangoz/features/chat/controller/chat_controller.dart';
import 'package:dangoz/features/chat/providers/message_reply_provider.dart';
import 'package:dangoz/features/chat/widgets/my_message_card.dart';
import 'package:dangoz/features/chat/widgets/sender_message_card.dart';
import 'package:dangoz/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ChatList extends ConsumerStatefulWidget {
  String recieverId;
  ChatList({super.key, required this.recieverId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.state).update(
          (state) => MessageReply(
            message,
            isMe,
            messageEnum,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
        stream: ref.read(chatControllerProvider).chatStream(widget.recieverId),
        builder: (context, snapshot) {
          if (snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Wave back...',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                const SizedBox(height: 20),
                LottieBuilder.asset(
                  'assets/animations/higator.json',
                  height: Get.height * 0.3,
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
              controller: messageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                print('ggg');
                print(messageData.messageId);
                print(snapshot.data![index].reciverId);
                if (!messageData.isSeen &&
                    messageData.reciverId ==
                        FirebaseAuth.instance.currentUser!.uid) {
                  print('test');
                  ref.read(chatControllerProvider).setChatMessageToSeen(
                        widget.recieverId,
                        messageData.messageId,
                      );
                }

                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return MyMessageCard(
                    message: messageData.message,
                    date: messageData.timeSent,
                    type: messageData.type,
                    repliedText: messageData.repliedMessage,
                    userName: messageData.repliedTo,
                    repliedMessageType: messageData.repliedMessageType,
                    onLeftSwipe: () => onMessageSwipe(
                      messageData.message,
                      true,
                      messageData.type,
                    ),
                    isSeen: messageData.isSeen,
                  );
                }
                return SenderMessageCard(
                  message: messageData.message,
                  date: messageData.timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  userName: messageData.repliedTo,
                  repliedMessageType: messageData.repliedMessageType,
                  onRightSwipe: () => onMessageSwipe(
                    messageData.message,
                    false,
                    messageData.type,
                  ),
                );
              });
        });
  }
}
