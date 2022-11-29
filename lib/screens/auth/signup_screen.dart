import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/buttons.dart';
import 'package:dangoz/controllers/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<SignupController>(
      builder: (signupController) {
        return Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.05),
              buildLogo(),
              SizedBox(height: Get.height * 0.05),
              buildForm(signupController),
              SizedBox(height: Get.height * 0.025),
              buildDatePicker(signupController),
              SizedBox(height: Get.height * 0.025),
              buildCheckbox(signupController),
              SizedBox(height: Get.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    print(signupController.emailController.text);
                    print(signupController.nameController.text);
                    print(signupController.passwordController.text);
                    print(signupController.birthday);
                    print(signupController.checkbox);
                    Get.toNamed('/loginScreen');
                  },
                  child: Buttons.primaryButton(
                    AppColors.navy,
                    AppColors.white,
                    'Sign Up',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget buildLogo() {
    return Column(
      children: [
        Container(
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
                  FlickerAnimatedText('Sign up'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForm(SignupController signupController) {
    return Form(
      key: signupController.formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: signupController.emailController,
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
              controller: signupController.nameController,
              validator: ((value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                }
              }),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                  vertical: Get.height * 0.02,
                ),
                hintText: 'Name',
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
              controller: signupController.passwordController,
              obscureText: !signupController.showPassword,
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
                suffixIcon: signupController.showPassword == false
                    ? InkWell(
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          signupController.updateShowpassword();
                        },
                        child: Icon(
                          CupertinoIcons.eye_slash_fill,
                          color: AppColors.lightGrey,
                        ))
                    : InkWell(
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          signupController.updateShowpassword();
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

  Widget buildDatePicker(SignupController signupController) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Text(
                'Birthday',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: Get.width * 0.04,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: Get.height * 0.11,
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                minimumYear: 1950,
                maximumYear: DateTime.now().year,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  signupController.updateBirthday(date);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildCheckbox(SignupController signupController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              signupController.updateCheckbox();
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
              child: signupController.checkbox == false
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
            child: RichText(
              text: TextSpan(
                text:
                    'By ticking, you are confirming that you have read, understood and agree to ',
                style: TextStyle(color: AppColors.grey),
                children: [
                  TextSpan(
                    text: 'Dangoz Terms & Conditions.',
                    style: TextStyle(color: AppColors.green),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('hello');
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
