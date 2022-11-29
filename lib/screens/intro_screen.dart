import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  double fourthDepth = 100;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? stagger(value, progress, delay) {
      progress = progress - (1 - delay);
      if (progress < 0) progress = 0;
      return value * (progress / delay);
    }

    double calculatedFourthDepth =
        stagger(fourthDepth, _animationController.value, 1)!;

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.05),
            SizedBox(
              child: Image.asset(
                'assets/images/dangozLogo.png',
                height: Get.height * 0.25,
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            dangozTitle(),
            SizedBox(height: Get.height * 0.025),
            animatedText(calculatedFourthDepth),
            SizedBox(height: Get.height * 0.025),
            signUp(calculatedFourthDepth),
            SizedBox(height: Get.height * 0.03),
            googleSignIn(calculatedFourthDepth),
            SizedBox(height: Get.height * 0.03),
            appleSignIn(calculatedFourthDepth),
            SizedBox(height: Get.height * 0.03),
            calculatedFourthDepth.toInt() < 40
                ? SizedBox(
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                  )
                : login(),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget animatedText(double calculatedFourthDepth) {
    return calculatedFourthDepth.toInt() < 5
        ? Container(
            height: 150,
          )
        : SizedBox(
            height: 150,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: Get.width * 0.055,
                      fontFamily: 'Horizon',
                      letterSpacing: 2,
                      color: AppColors.navy,
                      fontWeight: FontWeight.w500),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('Drive'),
                      RotateAnimatedText('Earn'),
                      RotateAnimatedText('Grow'),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget dangozTitle() {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: Get.width * 0.07,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(
            'Dangoz',
            textStyle: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
              color: AppColors.navy,
            ),
          ),
        ],
        isRepeatingAnimation: true,
        totalRepeatCount: 1,
        repeatForever: false,
      ),
    );
  }

  Widget signUp(double calculatedFourthDepth) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        Get.toNamed('/signupScreen');
      },
      child: Material(
        elevation: calculatedFourthDepth.toInt() < 10 ? 0 : 20,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            height: Get.height * 0.07,
            width: Get.width * 0.8,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            color: calculatedFourthDepth.toInt() < 10
                ? Colors.white
                : AppColors.navy,
            child: Center(
              child: calculatedFourthDepth.toInt() < 10
                  ? const Text('')
                  : Text(
                      'Sign Up',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: AppColors.white,
                          fontSize: Get.width * 0.04),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget googleSignIn(double calculatedFourthDepth) {
    return InkWell(
      onTap: () {},
      child: Material(
        elevation: calculatedFourthDepth.toInt() < 20 ? 0 : 20,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            height: Get.height * 0.07,
            width: Get.width * 0.8,
            duration: const Duration(seconds: 2),
            curve: Curves.easeIn,
            color: calculatedFourthDepth.toInt() < 20
                ? AppColors.white
                : AppColors.navy,
            child: Center(
              child: calculatedFourthDepth.toInt() < 20
                  ? const Text('')
                  : Text(
                      'Google Sign In',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: AppColors.white,
                          fontSize: Get.width * 0.04),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appleSignIn(double calculatedFourthDepth) {
    return InkWell(
      onTap: () {},
      child: Material(
        elevation: calculatedFourthDepth.toInt() < 30 ? 0 : 20,
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            height: Get.height * 0.07,
            width: Get.width * 0.8,
            duration: const Duration(seconds: 3),
            curve: Curves.easeIn,
            color: calculatedFourthDepth.toInt() < 30
                ? AppColors.white
                : AppColors.navy,
            child: Center(
              child: calculatedFourthDepth.toInt() < 30
                  ? const Text('')
                  : Text(
                      'Apple Sign In',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: AppColors.white,
                          fontSize: Get.width * 0.04),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget login() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: Get.width * 0.035,
            fontFamily: 'Agne',
            color: AppColors.navy),
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TypewriterAnimatedText(
              'Already have an account? Login',
              speed: const Duration(milliseconds: 80),
            ),
          ],
          onTap: () {
            //Login
          },
        ),
      ),
    );
  }
}
