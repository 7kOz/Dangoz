import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/chat/controller/chat_controller.dart';
import 'package:dangoz/features/chat/repository/chat_repository.dart';
import 'package:dangoz/features/chat/widgets/bottom_chat_bar.dart';
import 'package:dangoz/features/chat/widgets/chat_list.dart';
import 'package:dangoz/features/chat/widgets/sender_message_card.dart';
import 'package:dangoz/models/message_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatScreen extends ConsumerWidget {
  final String name;
  final String uid;
  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.navy,
        title: StreamBuilder<UserModel>(
          stream: ref.read(chatRepositoryProvider).userData(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            return Text(
              name,
              style: TextStyle(
                letterSpacing: 1,
                color: AppColors.white,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StreamBuilder<UserModel>(
              stream: ref.read(chatRepositoryProvider).userData(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                return Icon(
                  CupertinoIcons.circle_fill,
                  color: snapshot.data!.isOnline
                      ? AppColors.green
                      : AppColors.lightGrey,
                  size: Get.width * 0.035,
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(recieverId: uid),
          ),
          BottomChatBar(
            recieverId: uid,
          ),
          Container(
            height: Get.height * 0.025,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
