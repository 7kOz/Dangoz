import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/repositories/notifications_repository.dart';
import 'package:dangoz/features/drawer/widgets/menu_widget.dart';
import 'package:dangoz/features/notifications/screens/notifications_screen.dart';
import 'package:dangoz/features/posts/widgets/general_feed_list.dart';
import 'package:dangoz/features/posts/widgets/upload_post_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MainFeedScreen extends ConsumerStatefulWidget {
  const MainFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends ConsumerState<MainFeedScreen> {
  bool hidePostCard = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Dangoz',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: Get.width * 0.045,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        leading: const DrawerMenuWidget(),
        actions: [
          StreamBuilder(
              stream: ref
                  .read(notificationBellRepositoryProvider)
                  .notificationsBell(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(notificationBellRepositoryProvider)
                          .seenNotification();
                      Get.to(() => const NotificationsScreen());
                    },
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    child: snapshot.data['newNotif'] == false
                        ? Icon(
                            CupertinoIcons.bell,
                            color: AppColors.navy,
                            size: Get.width * 0.055,
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.015),
                            child: SizedBox(
                              width: Get.width * 0.09,
                              child: LottieBuilder.asset(
                                'assets/animations/notification.json',
                                repeat: false,
                                height: Get.height * 0.02,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                  ),
                );
              }),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: hidePostCard == true
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              hidePostCard = false;
                            },
                          );
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: Icon(
                          Icons.add,
                          color: AppColors.green,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        UploadPostContainer(),
                        Positioned(
                          top: Get.height * 0.01,
                          right: Get.width * 0.03,
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  hidePostCard = true;
                                },
                              );
                            },
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: Icon(
                              Icons.close,
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            GeneralFeedsList(
              height:
                  hidePostCard == true ? Get.height * 0.78 : Get.height * 0.475,
            ),
          ],
        ),
      ),
    );
  }
}
