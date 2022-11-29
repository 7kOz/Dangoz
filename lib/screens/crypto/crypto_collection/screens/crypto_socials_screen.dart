import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/socials_widgets/bearish_crypto_mentions.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/socials_widgets/bullish_crypto_mentions.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/socials_widgets/trending_mentions.dart';
import 'package:dangoz/screens/subscriptions/subscription_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CryptoSocialsScreen extends StatefulWidget {
  dynamic trendingCryptoMentions;
  dynamic bullishCryptoMentions;
  dynamic bearishCryptoMentions;
  CryptoSocialsScreen({
    Key? key,
    required this.trendingCryptoMentions,
    required this.bullishCryptoMentions,
    required this.bearishCryptoMentions,
  }) : super(key: key);

  @override
  State<CryptoSocialsScreen> createState() => _CryptoSocialsScreenState();
}

class _CryptoSocialsScreenState extends State<CryptoSocialsScreen> {
  bool onehourSocial = false;
  bool fourhourSocial = false;
  bool twelvehourSocial = false;
  bool dailySocial = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.025),
            Text(
              'Most mentioned coins on social platforms.',
              style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: Get.width * 0.03),
            ),
            SizedBox(height: Get.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    const SubscriptionPopup();
                  },
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: onehourSocial == false
                          ? AppColors.navy
                          : AppColors.green,
                    ),
                    child: Center(
                      child: Text(
                        '1h',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.03),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    const SubscriptionPopup();
                  },
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: fourhourSocial == false
                          ? AppColors.navy
                          : AppColors.green,
                    ),
                    child: Center(
                      child: Text(
                        '4h',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.03),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const SubscriptionPopup(),
                    );
                  },
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: twelvehourSocial == false
                          ? AppColors.navy
                          : AppColors.green,
                    ),
                    child: Center(
                      child: Text(
                        '12h',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.03),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:
                        dailySocial == false ? AppColors.navy : AppColors.green,
                  ),
                  child: Center(
                    child: Text(
                      'Daily',
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CarouselSlider(
              options: CarouselOptions(
                height: Get.height * 0.4,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
              ),
              items: [
                TrendingCryptoMentions(
                    trendingSocialStatsSnapshot: widget.trendingCryptoMentions),
                BullishCryptoMentions(
                    bullishSocialStatsSnapshot: widget.bullishCryptoMentions),
                BearishCryptoMentions(
                    bearishSocialStatsSnapshot: widget.bearishCryptoMentions),
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return i;
                  },
                );
              }).toList(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
