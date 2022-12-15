import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/buttons.dart';
import 'package:dangoz/controllers/signup_controller.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:dangoz/features/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  String email = '';
  String name = '';
  String userName = '';
  String password = '';
  String birthday = '';
  bool showPassword = false;
  bool acceptTermsAndConditions = false;

  List allEmails = [];
  bool emailAvailable = true;
  List allUserNames = [];
  bool userNameAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.05),
              buildLogo(),
              SizedBox(height: Get.height * 0.025),
              buildForm(),
              SizedBox(height: Get.height * 0.025),
              buildDatePicker(),
              SizedBox(height: Get.height * 0.025),
              buildCheckbox(),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: acceptTermsAndConditions == true
                      ? () {
                          //Get.toNamed('/loginScreen');

                          if (emailAvailable == true &&
                              userNameAvailable == true) {
                            print(email);
                            print(userName);
                            print(name);
                            print(birthday);
                            print(password);
                            if (email.isNotEmpty &&
                                userName.isNotEmpty &&
                                name.isNotEmpty &&
                                birthday.isNotEmpty &&
                                password.isNotEmpty) {
                              ref
                                  .read(authControllerProvider)
                                  .singUpWithEmailAndPassword(
                                    email,
                                    password,
                                    name,
                                    userName,
                                    birthday,
                                  );

                              Get.offAndToNamed('/navbarScreen');
                            } else {
                              Get.snackbar(
                                'Oops',
                                'Please Complete Sign Up Form',
                                backgroundColor: AppColors.red,
                                colorText: AppColors.white,
                              );
                            }
                          } else {
                            Get.snackbar(
                              'Oops',
                              'Email & Username Must Be Unique',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                            );
                          }
                        }
                      : () {
                          Get.snackbar(
                            'Oops',
                            'You Must Aggree To Dangoz Terms & Conditions',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                          );
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
        ),
      ),
    );
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
                repeatForever: false,
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

  Widget buildForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            onChanged: (value) async {
              setState(() {
                emailAvailable = true;
              });
              await FirebaseFirestore.instance
                  .collection('Users')
                  .get()
                  .then((value) {
                allEmails = value.docs
                    .map((QueryDocumentSnapshot<dynamic> doc) =>
                        doc.data()!['email'].toString())
                    .toList();
                return allEmails;
              });
              setState(() {
                if (allEmails.contains(value.toLowerCase())) {
                  emailAvailable = false;
                } else {
                  email = value.trim();
                }
              });
            },
            style: TextStyle(
                color: emailAvailable ? AppColors.navy : AppColors.red),
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
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            onChanged: (value) async {
              setState(() {
                userNameAvailable = true;
              });
              await FirebaseFirestore.instance
                  .collection('Users')
                  .get()
                  .then((value) {
                allUserNames = value.docs
                    .map((QueryDocumentSnapshot<dynamic> doc) =>
                        doc.data()!['userName'].toString())
                    .toList();
                return allUserNames;
              });
              setState(() {
                if (allUserNames.contains(value.toLowerCase())) {
                  userNameAvailable = false;
                } else {
                  userName = value.trim();
                }
              });
            },
            style: TextStyle(
                color:
                    userNameAvailable == true ? AppColors.navy : AppColors.red),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
                vertical: Get.height * 0.02,
              ),
              hintText: 'User Name',
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
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
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
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: showPassword,
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
              suffixIcon: showPassword == false
                  ? InkWell(
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        CupertinoIcons.eye_slash_fill,
                        color: AppColors.lightGrey,
                      ))
                  : InkWell(
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
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
    );
  }

  Widget buildDatePicker() => Padding(
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
                  setState(() {
                    birthday = date.toString();
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget buildCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                acceptTermsAndConditions = !acceptTermsAndConditions;
              });
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
              child: acceptTermsAndConditions == false
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
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: Get.width * 0.03,
                ),
                children: [
                  TextSpan(
                    text: 'Dangoz Terms & Conditions.',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: Get.width * 0.035,
                    ),
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
