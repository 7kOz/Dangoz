import 'package:dangoz/apis/crypto_apis/general_crypto_api.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/screens/crypto/crypto_collection/screens/coin_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Top1000CoinsWidget extends StatefulWidget {
  dynamic top1000CoinsByMarketCap;
  Top1000CoinsWidget({
    Key? key,
    required this.top1000CoinsByMarketCap,
  }) : super(key: key);

  @override
  State<Top1000CoinsWidget> createState() => _Top1000CoinsWidgetState();
}

class _Top1000CoinsWidgetState extends State<Top1000CoinsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height * 0.08,
          width: Get.width,
          color: AppColors.navy,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.08,
                  child: Center(
                    child: Text(
                      '#',
                      style: TextStyle(
                          color: AppColors.white, fontSize: Get.width * 0.0325),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: AppColors.white,
                ),
                Container(
                  width: Get.width * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ticker',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.width * 0.0325),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Market Cap',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.width * 0.0325),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: AppColors.white,
                ),
                Container(
                  width: Get.width * 0.18,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '24h %',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: AppColors.white,
                ),
                Container(
                  width: Get.width * 0.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '24h High',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '24h Low',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
            future: widget.top1000CoinsByMarketCap,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: Get.height * 0.5,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        int marketCap = snapshot.data![index]['market_cap'];
                        String formattedMarketCap = NumberFormat.compact(
                          locale: 'en_IN',
                        ).format(marketCap);

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => CoinDetailsScreen(
                                    title: snapshot.data![index]['symbol']
                                        .toString()
                                        .toUpperCase(),
                                    id: snapshot.data![index]['id'],
                                  ),
                                );
                              },
                              splashColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              child: Container(
                                height: Get.height * 0.08,
                                width: Get.width,
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: Get.width * 0.08,
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                color: AppColors.navy,
                                                fontSize: Get.width * 0.0325),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                      Container(
                                        width: Get.width * 0.2,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              snapshot.data![index]['image'],
                                              height: Get.height * 0.02,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        snapshot.data![index]
                                                                ['symbol']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                AppColors.navy,
                                                            fontSize:
                                                                Get.width *
                                                                    0.03),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      formattedMarketCap,
                                                      style: TextStyle(
                                                          color: AppColors.navy,
                                                          fontSize: Get.width *
                                                              0.025),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: Get.width * 0.18,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$${snapshot.data![index]['current_price']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppColors.green,
                                                      fontSize:
                                                          Get.width * 0.03),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '${snapshot.data![index]['price_change_percentage_24h'].toString().substring(0, 4)}%',
                                                  style: TextStyle(
                                                      color: snapshot
                                                                  .data![index][
                                                                      'price_change_percentage_24h']
                                                                  .toString()[0] ==
                                                              '-'
                                                          ? AppColors.red
                                                          : AppColors.green,
                                                      fontSize: Get.width * 0.03),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColors.lightGrey,
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: Get.width * 0.2,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\$${snapshot.data![index]['high_24h']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.green,
                                                      fontSize:
                                                          Get.width * 0.03),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '\$${snapshot.data![index]['low_24h']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.red,
                                                      fontSize:
                                                          Get.width * 0.03),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.lightGrey,
                            ),
                          ],
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Container();
              }
              return Container();
            }),
        Container(
          height: Get.height * 0.05,
          width: Get.width,
        )
      ],
    );
  }
}
