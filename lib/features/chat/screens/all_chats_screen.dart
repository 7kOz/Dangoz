import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/chat/controller/chat_controller.dart';
import 'package:dangoz/features/chat/screens/chat_screen.dart';
import 'package:dangoz/models/chat_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllChatsScreen extends ConsumerWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(
              color: AppColors.white,
              letterSpacing: 1,
              fontSize: Get.width * 0.04),
        ),
      ),
      body: StreamBuilder<List<ChatContactModel>>(
        stream: ref.watch(chatControllerProvider).chatContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          return snapshot.data!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Looks Like It\'s Only Us In Here',
                      style: TextStyle(
                        color: AppColors.navy,
                        letterSpacing: 1,
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    LottieBuilder.asset('assets/animations/ghost.json'),
                  ],
                )
              : Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var chatContactData = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => ChatScreen(
                                    name: chatContactData.name,
                                    uid: chatContactData.contactId,
                                  ),
                                );
                              },
                              splashColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              child: ListTile(
                                leading: chatContactData.profileImage == ''
                                    ? CircleAvatar(
                                        radius: 3,
                                        backgroundColor: AppColors.navy,
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            color: AppColors.white,
                                            size: Get.width * 0.05,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColors.navy,
                                        backgroundImage: NetworkImage(
                                            chatContactData.profileImage),
                                      ),
                                title: Text(
                                  chatContactData.name,
                                  style: TextStyle(
                                    color: AppColors.navy,
                                    letterSpacing: 1,
                                    fontSize: Get.width * 0.04,
                                  ),
                                ),
                                subtitle: Text(
                                  chatContactData.lastMessage,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    letterSpacing: 1,
                                    fontSize: Get.width * 0.03,
                                  ),
                                ),
                                trailing: Text(
                                  timeago.format(chatContactData.timeSent,
                                      locale: 'en_short'),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: 1,
                                    fontSize: Get.width * 0.03,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
