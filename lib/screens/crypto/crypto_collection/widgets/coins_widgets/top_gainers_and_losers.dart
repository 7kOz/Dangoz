import 'package:dangoz/base/app_colors.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class TopGainersAndLosersParent extends StatefulWidget {
  dynamic topGainersAndLosersSnapshot;
  TopGainersAndLosersParent({
    Key? key,
    required this.topGainersAndLosersSnapshot,
  }) : super(key: key);

  @override
  State<TopGainersAndLosersParent> createState() =>
      _TopGainersAndLosersParentState();
}

class _TopGainersAndLosersParentState extends State<TopGainersAndLosersParent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.topGainersAndLosersSnapshot,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Get.height * 0.27,
                width: Get.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.navy),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Center(
                      child: Text(
                        'Top Gainers ${Emoji.byName('flexed biceps')}',
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.035,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height * 0.23,
                      width: Get.width,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1.5, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data!['Top Gainers'][index]
                                          ['Symbol'],
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.width * 0.0325,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${snapshot.data!['Top Gainers'][index]['Price']}',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.width * 0.0325,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data!['Top Gainers'][index]['Rise 24hr']}',
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.width * 0.0325,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.27,
                width: Get.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.navy),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Center(
                      child: Text(
                        'Top Losers ${Emoji.byChar(Emojis.smilingFaceWithTear)}',
                        style: TextStyle(
                          color: AppColors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.035,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height * 0.23,
                      width: Get.width,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1.5, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data!['Top Losers'][index]
                                          ['Symbol'],
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.width * 0.0325,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${snapshot.data!['Top Losers'][index]['Price']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.width * 0.0325,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data!['Top Losers'][index]['Drop 24hr']}',
                                    style: TextStyle(
                                      color: AppColors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.width * 0.0325,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return const Text('Error');
        }
        return Container();
      },
    );
  }
}
