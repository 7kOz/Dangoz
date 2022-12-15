import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/chat/providers/message_reply_provider.dart';
import 'package:dangoz/features/chat/widgets/display_text_attachments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({super.key});

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(16),
          ),
          width: Get.width * 0.85,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      messageReply!.isMe ? 'Replying To: Me' : 'Replying',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => cancelReply(ref),
                    child: Icon(
                      Icons.close,
                      size: Get.width * 0.05,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: Get.height * 0.45,
                        maxWidth: Get.width * 0.85),
                    child: DisplayTextAttachments(
                        message: messageReply.message,
                        type: messageReply.messageEnum),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
