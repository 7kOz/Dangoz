import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SubscriptionPopup extends StatelessWidget {
  const SubscriptionPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 50,
        content: Container(
          height: Get.height * 0.9,
          width: Get.width * 0.9,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.2,
                width: Get.width * 0.9,
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      Center(
                        child: Text(
                          'Basic',
                          style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w400,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Verified ',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Reposting ',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '1h-4h-12h Crypto Socials ',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '1h-4h-12h Stocks Socials ',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Crypto Forex Stocks Corelations ',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Multiple Portfolios ',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: Get.height * 0.33,
                width: Get.width * 0.9,
                color: AppColors.navy,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      Center(
                        child: Text(
                          'Pro',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Verified ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.check_mark,
                            color: AppColors.green,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '4h-12h Crypto Socials ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.check_mark,
                            color: AppColors.green,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '4h-12h Stocks Socials ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.check_mark,
                            color: AppColors.green,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Multiple Portfolios ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.check_mark,
                            color: AppColors.green,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Reposting ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '1h Crypto Socials ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '1h Stocks Socials ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Crypto Forex Stocks Corelations ',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.red,
                            size: Get.width * 0.03,
                          )
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: Container(
                          height: Get.height * 0.055,
                          width: Get.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white),
                          child: Center(
                              child: Text(
                            'Upgrade To Pro \$5 / Month',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w700,
                              fontSize: Get.width * 0.038,
                            ),
                          )),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Container(
                height: Get.height * 0.33,
                width: Get.width * 0.9,
                color: AppColors.green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      Center(
                        child: Text(
                          'Premium',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: Get.width * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Verified ',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Reposting ',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '1h-4h-12h Crypto Socials ',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        '1h-4h-12h Stocks Socials ',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Crypto Forex Stocks Corelations ',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Multiple Portfolios ',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: Container(
                          height: Get.height * 0.065,
                          width: Get.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white),
                          child: Center(
                              child: Text(
                            'Upgrade To Premium \$8 / Month',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w700,
                              fontSize: Get.width * 0.038,
                              letterSpacing: 1,
                            ),
                          )),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
