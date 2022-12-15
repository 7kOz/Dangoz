import 'package:dangoz/base/app_colors.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_ns/liquid_progress_indicator.dart';

class TrendingCryptoMentions extends StatefulWidget {
  dynamic trendingSocialStatsSnapshot;
  TrendingCryptoMentions({
    Key? key,
    required this.trendingSocialStatsSnapshot,
  }) : super(key: key);

  @override
  State<TrendingCryptoMentions> createState() => _TrendingCryptoMentionsState();
}

class _TrendingCryptoMentionsState extends State<TrendingCryptoMentions> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.trendingSocialStatsSnapshot,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: Get.height * 0.4,
              width: Get.width,
              child: LiquidLinearProgressIndicator(
                value: 0.0, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(AppColors
                    .navy), // Defaults to the current Theme's accentColor.
                backgroundColor: AppColors
                    .navy, // Defaults to the current Theme's backgroundColor.
                borderColor: AppColors.navy,
                borderWidth: 5.0,
                borderRadius: 12.0,
                direction: Axis
                    .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                center: Stack(
                  children: [
                    Positioned(
                      top: Get.height * 0.01,
                      left: Get.width * 0.395,
                      child: Text(
                        'Trending ${Emoji.byChar(Emojis.fire)}',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.04),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.1, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: AppColors
                              .navy, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.025,
                        child: Text(
                          snapshot.data![9]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.1,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.2, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: AppColors
                              .navy, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.125,
                        child: Text(
                          snapshot.data![8]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.2,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.3, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.225,
                        child: Text(
                          snapshot.data![7]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.3,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.4, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.325,
                        child: Text(
                          snapshot.data![6]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.4,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.5, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.425,
                        child: Text(
                          snapshot.data![5]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.5,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.6, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.525,
                        child: Text(
                          snapshot.data![4]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.6,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.7, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(Colors
                              .blueAccent), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.625,
                        child: Text(
                          snapshot.data![3]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.7,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.8, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.725,
                        child: Text(
                          snapshot.data![2]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.8,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 0.9, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.825,
                        child: Text(
                          snapshot.data![1]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: Get.width * 0.9,
                      child: Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.1,
                        child: LiquidLinearProgressIndicator(
                          value: 1, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.blueAccent,
                          ), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .transparent, // Defaults to the current Theme's backgroundColor.
                          borderColor: AppColors.navy,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis.vertical,
                          center: Container(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: Get.height * 0.01,
                        left: Get.width * 0.925,
                        child: Text(
                          snapshot.data![0]['ticker']
                              .toString()
                              .substring(0, 3),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width * 0.025,
                          ),
                        )),
                  ],
                ),
              ));
        } else if (snapshot.hasError) {
          //print(snapshot.error);
          return const Text('Error');
        }
        return Container();
      },
    );
  }
}
