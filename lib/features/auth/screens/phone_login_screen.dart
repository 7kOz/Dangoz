import 'package:country_picker/country_picker.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
        print('Select country: ${country!.displayName}');
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhone(
            '+${country!.phoneCode}$phoneNumber',
          );
    } else {
      Get.snackbar(
        'Missing Fields',
        'Country Code & Phone Number Are Required',
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.navy,
        title: Text(
          'Phone Login',
          style: TextStyle(
            color: AppColors.white,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            fontSize: Get.width * 0.045,
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              child: Image.asset(
                'assets/images/dangozLogo.png',
                height: Get.height * 0.225,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: pickCountry,
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.225,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.navy,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          country != null
                              ? '+${country!.phoneCode}'
                              : 'Country Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.navy,
                              fontSize: Get.width * 0.03),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.625,
                    child: TextFormField(
                      controller: phoneController,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Phone Number is required';
                        }
                      }),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.04,
                          vertical: Get.height * 0.02,
                        ),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: AppColors.navy,
                          fontSize: Get.width * 0.04,
                        ),
                        filled: true,
                        fillColor: Colors.white,
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
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: sendPhoneNumber,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  height: Get.height * 0.07,
                  width: Get.width * 0.8,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeIn,
                  color: AppColors.navy,
                  child: Center(
                    child: Text(
                      'Phone Sign In',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: AppColors.white,
                          fontSize: Get.width * 0.04),
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


// Container(
//                     height: Get.height * 0.05,
//                     width: Get.width * 0.625,
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       border: Border(
//                         bottom: BorderSide(
//                           color: AppColors.navy,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Phone Number',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: AppColors.navy, fontSize: Get.width * 0.03),
//                       ),
//                     ),
//                   ),