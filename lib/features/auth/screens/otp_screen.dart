import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OTPScreen extends ConsumerWidget {
  final String verificationId;
  OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, String userOTP) {
    ref.read(authControllerProvider).verifyOtp(verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.075),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    child: Icon(
                      CupertinoIcons.chevron_back,
                      color: AppColors.navy,
                      size: Get.width * 0.075,
                    ),
                  ),
                  Text(
                    'Verifying Your Number',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_back,
                    color: Colors.transparent,
                    size: Get.width * 0.075,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Center(
              child: LottieBuilder.asset(
                'assets/animations/otp.json',
                height: Get.height * 0.4,
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Center(
              child: Text(
                'We have sent an SMS with a code',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: Get.width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.1),
            Center(
              child: SizedBox(
                height: Get.height * 0.05,
                width: Get.width * 0.3,
                child: TextField(
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: Get.width * 0.05,
                  ),
                  onChanged: (val) {
                    if (val.length == 6) {
                      verifyOTP(
                        ref,
                        val.trim(),
                      );
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '- - - - - -',
                    hintStyle: TextStyle(
                      color: AppColors.green,
                      fontSize: Get.width * 0.05,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.navy,
                        width: 1,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.navy,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
