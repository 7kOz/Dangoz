import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExchangesScreen extends StatefulWidget {
  dynamic exchangesSnapshot;
  ExchangesScreen({
    Key? key,
    required this.exchangesSnapshot,
  }) : super(key: key);

  @override
  State<ExchangesScreen> createState() => _ExchangesScreenState();
}

class _ExchangesScreenState extends State<ExchangesScreen> {
  bool trustScore = true;
  bool volumeBtc = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.025),
            Container(
              height: Get.height * 0.05,
              width: Get.width,
              color: AppColors.navy,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Get.width * 0.07,
                    ),
                    VerticalDivider(
                      color: AppColors.white,
                    ),
                    Container(
                      width: Get.width * 0.09,
                      child: Center(
                        child: Text(
                          'Trust\nScore',
                          style: TextStyle(
                              color: trustScore == true
                                  ? AppColors.green
                                  : AppColors.white,
                              fontSize: Get.width * 0.0325),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: AppColors.white,
                    ),
                    Container(
                      width: Get.width * 0.2,
                      child: Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: AppColors.white,
                    ),
                    Container(
                      width: Get.width * 0.25,
                      child: Center(
                        child: Text(
                          'Country',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: AppColors.white,
                    ),
                    Container(
                      width: Get.width * 0.1,
                      child: Center(
                        child: Text(
                          '24h V\nBTC',
                          style: TextStyle(
                              color: volumeBtc == true
                                  ? AppColors.green
                                  : AppColors.white,
                              fontSize: Get.width * 0.0325),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: widget.exchangesSnapshot,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: Get.height * 0.65,
                    width: Get.width,
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var trustScoreList = snapshot.data!;

                          var volumeBtcList = snapshot.data!;

                          // print(volumeBtcList
                          //   ..sort((a, b) => a['trade_volume_24h_btc']
                          //       .compareTo(b['trade_volume_24h_btc'])));

                          return Column(
                            children: [
                              Container(
                                height: Get.height * 0.05,
                                width: Get.width,
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: Get.width * 0.07,
                                        child: Image.network(
                                          trustScoreList[index]['image'],
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.grey,
                                      ),
                                      Container(
                                        width: Get.width * 0.09,
                                        child: Center(
                                          child: Text(
                                            trustScoreList[index]
                                                    ['trust_score_rank']
                                                .toString(),
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: Get.width * 0.0325),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.grey,
                                      ),
                                      Container(
                                        width: Get.width * 0.2,
                                        child: Center(
                                          child: Text(
                                            trustScoreList[index]['name'] ?? '',
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: Get.width * 0.0325),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.grey,
                                      ),
                                      Container(
                                        width: Get.width * 0.25,
                                        child: Center(
                                          child: Text(
                                            trustScoreList[index]['country'] ??
                                                '',
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: Get.width * 0.0325),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.grey,
                                      ),
                                      Container(
                                        width: Get.width * 0.1,
                                        child: Center(
                                          child: Text(
                                            NumberFormat.compact(
                                              locale: 'en_IN',
                                            )
                                                .format(trustScoreList[index]
                                                    ['trade_volume_24h_btc'])
                                                .toString(),
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: Get.width * 0.0325),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.grey,
                              ),
                            ],
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  print('error');
                } else {}
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
