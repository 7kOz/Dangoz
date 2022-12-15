import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/enums/message_enums.dart';
import 'package:dangoz/features/chat/widgets/display_text_attachments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:get/get.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyMessageCard extends StatelessWidget {
  final String message;
  final DateTime date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String userName;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.userName,
    required this.repliedMessageType,
    required this.isSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: ChatBubble(
        clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        shadowColor: AppColors.navy,
        elevation: 5,
        backGroundColor: AppColors.navy,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.65,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.65,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isReplying) ...[
                        Text(
                          userName,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.green,
                              fontSize: Get.width * 0.0375),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DisplayTextAttachments(
                            message: repliedText,
                            type: repliedMessageType,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      DisplayTextAttachments(message: message, type: type),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    CupertinoIcons.eye,
                    color: isSeen ? AppColors.green : AppColors.lightGrey,
                    size: Get.width * 0.04,
                  ),
                  Text(
                    timeago.format(date, locale: 'en_short'),
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: Get.width * 0.025,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
