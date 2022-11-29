import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/buttons.dart';
import 'package:dangoz/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<LoginController>(
      builder: (loginController) {
        return Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(height: Get.height * 0.05),
              buildLogo(),
              const Spacer(),
              SizedBox(height: Get.height * 0.025),
              buildForm(loginController),
              SizedBox(height: Get.height * 0.025),
              buildCheckbox(loginController),
              SizedBox(height: Get.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: InkWell(
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {},
                  child: Buttons.squareButton(
                    AppColors.navy,
                    AppColors.white,
                    '',
                    'assets/animations/faceId.json',
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Get.offAndToNamed('/navbarScreen');
                  },
                  child: Buttons.primaryButton(
                    AppColors.navy,
                    AppColors.white,
                    'Login',
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    ));
  }

  Widget buildLogo() {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            'assets/images/dangozLogo.png',
            height: Get.height * 0.15,
          ),
        ),
        SizedBox(height: Get.height * 0.025),
        SizedBox(
          height: 50,
          width: Get.width,
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 30,
                color: AppColors.navy,
                shadows: [
                  Shadow(
                    blurRadius: 7.0,
                    color: AppColors.navy,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText('Login'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForm(LoginController loginController) {
    return Form(
      key: loginController.formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: loginController.emailController,
              validator: ((value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                  vertical: Get.height * 0.02,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: Get.width * 0.04,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.navy, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.navy, width: 2)),
                labelStyle: TextStyle(color: AppColors.navy),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.navy, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.025),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: loginController.passwordController,
              obscureText: !loginController.showPassword,
              validator: ((value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                  vertical: Get.height * 0.02,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: Get.width * 0.04,
                ),
                suffixIcon: loginController.showPassword == false
                    ? InkWell(
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          loginController.updateShowpassword();
                        },
                        child: Icon(
                          CupertinoIcons.eye_slash_fill,
                          color: AppColors.lightGrey,
                        ))
                    : InkWell(
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          loginController.updateShowpassword();
                        },
                        child: Icon(
                          CupertinoIcons.eye_fill,
                          color: AppColors.lightGrey,
                        )),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.navy, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.navy, width: 2)),
                labelStyle: TextStyle(color: AppColors.navy),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.navy, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckbox(LoginController loginController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              loginController.updateCheckbox();
            },
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Container(
              height: Get.height * 0.025,
              width: Get.height * 0.025,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: AppColors.navy,
                ),
              ),
              child: loginController.checkbox == false
                  ? Container()
                  : Center(
                      child: Icon(
                        CupertinoIcons.checkmark_seal_fill,
                        size: Get.height * 0.02,
                        color: AppColors.green,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Remember Me',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Forgot Password',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
