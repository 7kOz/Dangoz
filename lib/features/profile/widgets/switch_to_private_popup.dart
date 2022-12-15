import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SwitchToPrivatePopUp extends ConsumerWidget {
  const SwitchToPrivatePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      contentPadding: EdgeInsets.zero,
      elevation: 50,
      content: Container(
        height: Get.height * 0.5,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Center(
              child: LottieBuilder.asset(
                'assets/animations/lock.json',
                height: Get.height * 0.1,
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Switching your profile to private will limit interactions since only people who follow you will be able to view and interact with your posts.',
                style: TextStyle(
                    color: AppColors.grey, fontSize: Get.width * 0.035),
              ),
            ),
            Spacer(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SlideAction(
                  onSubmit: () {
                    ref.read(profileControllerProvider).switchAccounToPrivate();
                    Navigator.pop(context);
                  },
                  sliderButtonIcon: Icon(
                    CupertinoIcons.lock_fill,
                    color: AppColors.white,
                    size: Get.width * 0.05,
                  ),
                  submittedIcon: Icon(
                    CupertinoIcons.lock_fill,
                    color: AppColors.green,
                    size: Get.width * 0.05,
                  ),
                  borderRadius: 16,
                  innerColor: AppColors.green,
                  outerColor: AppColors.navy,
                  text: '      Switch To Private',
                  textStyle: TextStyle(
                    fontSize: Get.width * 0.04,
                    color: AppColors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(height: Get.height * 0.025),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.red,
                  ),
                  child: Center(
                      child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.white,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.025),
          ],
        ),
      ),
    );
  }
}
