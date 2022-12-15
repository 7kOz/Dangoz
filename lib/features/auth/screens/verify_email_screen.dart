import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Please Verify Your Email',
                style: TextStyle(
                    color: AppColors.navy, fontSize: Get.width * 0.04),
              ),
              const SizedBox(height: 20),
              Text(
                'We Have Sent You An Email Check Your Inbox Sometimes Mails End Up In Spam',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.navy, fontSize: Get.width * 0.03),
              ),
              LottieBuilder.asset('assets/animations/verifyEmail.json'),
              const SizedBox(height: 40),
              Text(
                'Didn\'t Reveive An Email?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: AppColors.red, fontSize: Get.width * 0.03),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  try {
                    final user = FirebaseAuth.instance.currentUser!;
                    await user.sendEmailVerification();
                  } catch (e) {
                    print(e);
                  }
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Buttons.primaryButton(
                    AppColors.navy, AppColors.green, 'Resend Verification'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
