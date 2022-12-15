import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangoz/features/crypto/crypto_collection/widgets/coins_widgets/fear_meter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FearMeterParent extends StatefulWidget {
  dynamic dailyFearIndexSnapshot;
  dynamic weeklyFearIndexSanpshot;
  dynamic monthlyFearIndexSnapshot;
  FearMeterParent({
    Key? key,
    required this.dailyFearIndexSnapshot,
    required this.weeklyFearIndexSanpshot,
    required this.monthlyFearIndexSnapshot,
  }) : super(key: key);

  @override
  State<FearMeterParent> createState() => _FearMeterParentState();
}

class _FearMeterParentState extends State<FearMeterParent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.dailyFearIndexSnapshot,
        builder: (BuildContext context, AsyncSnapshot dailySnapshot) {
          if (dailySnapshot.hasData) {
            return FutureBuilder(
                future: widget.weeklyFearIndexSanpshot,
                builder: (BuildContext context, AsyncSnapshot weeklySnapshot) {
                  List weeklyValuesList = [];
                  double weeklyValue = 0.0;
                  for (int i = 0; i < weeklySnapshot.data!.length; i++) {
                    weeklyValuesList.add(
                        int.parse(weeklySnapshot.data![i]['value']).toDouble());
                  }

                  for (int i = 0; i < weeklyValuesList.length; i++) {
                    weeklyValue += weeklyValuesList[i];
                  }

                  weeklyValue = weeklyValue / weeklySnapshot.data!.length;

                  if (weeklySnapshot.hasData) {
                    return Container(
                      height: Get.height * 0.35,
                      child: FutureBuilder(
                          future: widget.monthlyFearIndexSnapshot,
                          builder: (BuildContext context,
                              AsyncSnapshot monthlySnapshot) {
                            List monthlyValuesList = [];
                            double monthlyValue = 0.0;
                            for (int i = 0;
                                i < monthlySnapshot.data!.length;
                                i++) {
                              monthlyValuesList.add(
                                  int.parse(monthlySnapshot.data![i]['value'])
                                      .toDouble());
                            }

                            for (int i = 0; i < monthlyValuesList.length; i++) {
                              monthlyValue += monthlyValuesList[i];
                            }

                            monthlyValue =
                                monthlyValue / monthlySnapshot.data!.length;

                            if (monthlySnapshot.hasData) {
                              return CarouselSlider(
                                options: CarouselOptions(
                                  height: 400.0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                ),
                                items: [
                                  FearMeter(
                                    timeRange: 'Daily',
                                    fearString: dailySnapshot
                                        .data!['value_classification'],
                                    value:
                                        int.parse(dailySnapshot.data!['value'])
                                            .toDouble(),
                                  ),
                                  FearMeter(
                                    timeRange: 'Weekly',
                                    fearString: weeklyValue <= 24
                                        ? 'Extreme Fear'
                                        : weeklyValue <= 49
                                            ? 'Fear'
                                            : weeklyValue <= 79
                                                ? 'Greed'
                                                : 'Extreme Greed',
                                    value: weeklyValue,
                                  ),
                                  FearMeter(
                                    timeRange: 'Monthly',
                                    fearString: monthlyValue <= 24
                                        ? 'Extreme Fear'
                                        : monthlyValue <= 49
                                            ? 'Fear'
                                            : monthlyValue <= 79
                                                ? 'Greed'
                                                : 'Extreme Greed',
                                    value: monthlyValue,
                                  ),
                                ].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return i;
                                    },
                                  );
                                }).toList(),
                              );
                            } else if (dailySnapshot.hasError) {
                              return Container();
                            }
                            return Container();
                          }),
                    );
                  } else if (dailySnapshot.hasError) {
                    return Container();
                  }
                  return Container();
                });
          } else if (dailySnapshot.hasError) {
            return Container();
          }
          return Container();
        });
  }
}
