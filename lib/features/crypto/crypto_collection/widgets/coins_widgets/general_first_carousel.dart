import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class GeneralFirstCarousel extends StatefulWidget {
  AsyncSnapshot snapshot;
  GeneralFirstCarousel({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<GeneralFirstCarousel> createState() => _GeneralFirstCarouselState();
}

class _GeneralFirstCarouselState extends State<GeneralFirstCarousel> {
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
                  'Cryptos',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  widget.snapshot.data!['data']['active_cryptocurrencies']
                      .toString(),
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Markets',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  widget.snapshot.data!['data']['markets'].toString(),
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
