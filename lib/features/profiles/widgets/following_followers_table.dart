import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FollowingsFollowersTable extends StatelessWidget {
  int followings;
  int followers;
  FollowingsFollowersTable(
      {Key? key, required this.followings, required this.followers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: Get.height * 0.05,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Following',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.035,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  NumberFormat.compact(locale: 'en_US').format(followings),
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: Get.width * 0.03,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Followers',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.035,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  NumberFormat.compact(locale: 'en_US').format(followers),
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: Get.width * 0.03,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
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
