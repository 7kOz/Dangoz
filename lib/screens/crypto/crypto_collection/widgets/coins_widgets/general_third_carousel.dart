import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class GeneralThirdCarousel extends StatefulWidget {
  AsyncSnapshot snapshotMarketcap;
  String volume;
  GeneralThirdCarousel({
    Key? key,
    required this.snapshotMarketcap,
    required this.volume,
  }) : super(key: key);

  @override
  State<GeneralThirdCarousel> createState() => _GeneralThirdCarouselState();
}

class _GeneralThirdCarouselState extends State<GeneralThirdCarousel> {
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
                  'Volume',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  '\$ ${widget.volume}',
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  '${widget.snapshotMarketcap.data!['volume_24h_change_24h'].toString().substring(0, 4)} %',
                  style: TextStyle(
                    color: widget.snapshotMarketcap
                                .data!['volume_24h_change_24h']
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ATH Volume',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.04,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(
                '${widget.snapshotMarketcap.data['volume_24h_percent_from_ath']} %',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
