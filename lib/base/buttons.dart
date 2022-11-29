import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Buttons {
  static Widget primaryButton(Color color, Color textColor, String text) {
    return Material(
      elevation: 20,
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: Get.height * 0.07,
          width: Get.width,
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                letterSpacing: 1,
                color: textColor,
                fontSize: Get.width * 0.04,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget squareButton(
      Color color, Color textColor, String text, String animation) {
    return Material(
      elevation: 20,
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: Get.width * 0.25,
          width: Get.width * 0.25,
          color: color,
          child: Center(
            child: text == ''
                ? SizedBox(
                    child: LottieBuilder.asset(
                      animation,
                      height: Get.width * 0.25,
                      width: Get.width * 0.25,
                      fit: BoxFit.fill,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      letterSpacing: 1,
                      color: textColor,
                      fontSize: Get.width * 0.04,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
