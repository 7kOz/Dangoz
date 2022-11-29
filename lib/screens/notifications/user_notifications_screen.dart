import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserNotificationsScreen extends StatelessWidget {
  const UserNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 0.9,
        width: Get.width,
        color: AppColors.white,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.07),
            Center(
              child: LottieBuilder.asset(
                'assets/animations/notification.json',
                height: Get.height * 0.05,
                repeat: true,
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Container(
                      height: Get.height * 0.86,
                      width: Get.width,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.75,
                  width: Get.width,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: Get.height * 0.12,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.notifications,
                                color: AppColors.red,
                              ),
                              title: Text(
                                'Notification Title',
                                style: TextStyle(color: AppColors.green),
                              ),
                              subtitle: Text(
                                'Notification info',
                                style: TextStyle(color: AppColors.navy),
                              ),
                            ),
                            Divider(color: AppColors.navy),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
