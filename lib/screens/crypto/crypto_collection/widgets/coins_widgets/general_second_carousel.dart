import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class GeneralSecondCarousel extends StatefulWidget {
  AsyncSnapshot snapshot;
  String marketCap;
  List marketCapPercentageKeys;
  List marketCapPercentageValues;
  GeneralSecondCarousel({
    Key? key,
    required this.snapshot,
    required this.marketCap,
    required this.marketCapPercentageKeys,
    required this.marketCapPercentageValues,
  }) : super(key: key);

  @override
  State<GeneralSecondCarousel> createState() => _GeneralSecondCarouselState();
}

class _GeneralSecondCarouselState extends State<GeneralSecondCarousel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: Get.height,
          width: Get.width * 0.35,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.navy, width: 2),
            borderRadius: BorderRadius.circular(24),
            color: AppColors.navy,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MarketCap',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  '\$ ${widget.marketCap}',
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  '${widget.snapshot.data!['data']['market_cap_change_percentage_24h_usd'].toString().substring(0, 4)} %',
                  style: TextStyle(
                    color: widget
                                .snapshot
                                .data!['data']
                                    ['market_cap_change_percentage_24h_usd']
                                .toString()[0] ==
                            '-'
                        ? AppColors.red
                        : AppColors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.03,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: Get.height,
          width: Get.width * 0.35,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.navy, width: 2),
            borderRadius: BorderRadius.circular(24),
            color: AppColors.navy,
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.marketCapPercentageKeys[0]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Text(
                        '${widget.marketCapPercentageValues[0].toString().substring(0, 4)} %',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.marketCapPercentageKeys[1]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Text(
                        '${widget.marketCapPercentageValues[1].toString().substring(0, 4)} %',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.marketCapPercentageKeys[2]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Text(
                        '${widget.marketCapPercentageValues[2].toString().substring(0, 4)} %',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.marketCapPercentageKeys[3]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Text(
                        '${widget.marketCapPercentageValues[3].toString().substring(0, 4)} %',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.marketCapPercentageKeys[4]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Text(
                        '${widget.marketCapPercentageValues[4].toString().substring(0, 4)} %',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.marketCapPercentageKeys[5]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                      Text(
                        '${widget.marketCapPercentageValues[5].toString().substring(0, 4)} %',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
