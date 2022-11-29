import 'dart:async';

import 'package:dangoz/apis/crypto_apis/general_crypto_api.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/screens/crypto/crypto_collection/screens/coin_details_screen.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/coins_widgets/fear_meter_parent.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/coins_widgets/general_parent.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/coins_widgets/top_1000_coins_widget.dart';
import 'package:dangoz/screens/crypto/crypto_collection/widgets/coins_widgets/top_gainers_and_losers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loadmore/loadmore.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CoinsScreen extends StatefulWidget {
  bool loading;
  dynamic cryptoMarketGeneralViewSnapshot;
  dynamic cryptoMarketCapSnapshot;
  dynamic dailyFearIndexSnapshot;
  dynamic weeklyFearIndexSanpshot;
  dynamic monthlyFearIndexSnapshot;
  dynamic topGainersAndLosersSnapshot;
  dynamic top1000CoinsByMarketCap;
  dynamic allCoins1;
  dynamic allCoins2;
  dynamic allCoins3;
  dynamic allCoins4;
  dynamic allCoins5;
  dynamic allCoins6;
  dynamic allCoins7;
  dynamic allCoins8;
  dynamic allCoins9;
  dynamic allCoins10;
  CoinsScreen({
    Key? key,
    required this.loading,
    required this.cryptoMarketGeneralViewSnapshot,
    required this.cryptoMarketCapSnapshot,
    required this.dailyFearIndexSnapshot,
    required this.weeklyFearIndexSanpshot,
    required this.monthlyFearIndexSnapshot,
    required this.topGainersAndLosersSnapshot,
    required this.top1000CoinsByMarketCap,
    required this.allCoins1,
    required this.allCoins2,
    required this.allCoins3,
    required this.allCoins4,
    required this.allCoins5,
    required this.allCoins6,
    required this.allCoins7,
    required this.allCoins8,
    required this.allCoins9,
    required this.allCoins10,
  }) : super(key: key);

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}

class _CoinsScreenState extends State<CoinsScreen> {
  bool loadingInit = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (widget.cryptoMarketGeneralViewSnapshot != null &&
          widget.cryptoMarketCapSnapshot != null &&
          widget.dailyFearIndexSnapshot != null &&
          widget.weeklyFearIndexSanpshot != null &&
          widget.monthlyFearIndexSnapshot != null &&
          widget.topGainersAndLosersSnapshot != null) {
        setState(() {
          loadingInit = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loadingInit == true
        ? Center(child: SpinKitCubeGrid(color: AppColors.navy))
        : LiquidPullToRefresh(
            height: Get.height * 0.3,
            color: AppColors.navy,
            backgroundColor: AppColors.white,
            onRefresh: () async {
              setState(() {
                widget.cryptoMarketGeneralViewSnapshot =
                    GeneralCryptoApi().getCryptoMarketGeneralView();
                widget.cryptoMarketCapSnapshot =
                    GeneralCryptoApi().getCryptoMarketCap();
                widget.dailyFearIndexSnapshot =
                    GeneralCryptoApi().getDailyFearIndex();
                widget.weeklyFearIndexSanpshot =
                    GeneralCryptoApi().getWeeklyFearIndex();
                widget.monthlyFearIndexSnapshot =
                    GeneralCryptoApi().getMonthlyFearIndex();
                widget.topGainersAndLosersSnapshot =
                    GeneralCryptoApi().getTopGainersAndLosers();
                widget.top1000CoinsByMarketCap =
                    GeneralCryptoApi().getTop1000CoinsByMarketCap();
                widget.allCoins1 = GeneralCryptoApi().getAllCoins1();
                widget.allCoins2 = GeneralCryptoApi().getAllCoins2();
                widget.allCoins3 = GeneralCryptoApi().getAllCoins3();
                widget.allCoins4 = GeneralCryptoApi().getAllCoins4();
                widget.allCoins5 = GeneralCryptoApi().getAllCoins5();
                widget.allCoins6 = GeneralCryptoApi().getAllCoins6();
                widget.allCoins7 = GeneralCryptoApi().getAllCoins7();
                widget.allCoins8 = GeneralCryptoApi().getAllCoins8();
                widget.allCoins9 = GeneralCryptoApi().getAllCoins9();
                widget.allCoins10 = GeneralCryptoApi().getAllCoins10();
              });
            },
            showChildOpacityTransition: false,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: Get.height * 0.025),
                FutureBuilder(
                    future: widget.allCoins1,
                    builder: (BuildContext context, AsyncSnapshot snapshot1) {
                      List<String> allCoins = [];
                      List<String> allIds = [];

                      for (int i = 0; i < snapshot1.data!.length; i++) {
                        allCoins.add(snapshot1.data![i]['symbol']
                            .toString()
                            .toUpperCase());
                      }

                      for (int i = 0; i < snapshot1.data!.length; i++) {
                        allIds.add(snapshot1.data![i]['id'].toString());
                      }

                      if (snapshot1.hasData) {
                        return FutureBuilder(
                            future: widget.allCoins2,
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot2) {
                              for (int i = 0; i < snapshot2.data!.length; i++) {
                                allCoins.add(snapshot2.data![i]['symbol']
                                    .toString()
                                    .toUpperCase());
                              }

                              for (int i = 0; i < snapshot2.data!.length; i++) {
                                allIds.add(snapshot2.data![i]['id'].toString());
                              }

                              if (snapshot2.hasData) {
                                return FutureBuilder(
                                    future: widget.allCoins3,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot3) {
                                      for (int i = 0;
                                          i < snapshot3.data!.length;
                                          i++) {
                                        allCoins.add(snapshot3.data![i]
                                                ['symbol']
                                            .toString()
                                            .toUpperCase());
                                      }

                                      for (int i = 0;
                                          i < snapshot3.data!.length;
                                          i++) {
                                        allIds.add(snapshot3.data![i]['id']
                                            .toString());
                                      }

                                      if (snapshot3.hasData) {
                                        return FutureBuilder(
                                            future: widget.allCoins4,
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot4) {
                                              for (int i = 0;
                                                  i < snapshot4.data!.length;
                                                  i++) {
                                                allCoins.add(snapshot4.data![i]
                                                        ['symbol']
                                                    .toString()
                                                    .toUpperCase());
                                              }

                                              for (int i = 0;
                                                  i < snapshot4.data!.length;
                                                  i++) {
                                                allIds.add(snapshot4.data![i]
                                                        ['id']
                                                    .toString());
                                              }

                                              if (snapshot4.hasData) {
                                                return FutureBuilder(
                                                    future: widget.allCoins5,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot5) {
                                                      for (int i = 0;
                                                          i <
                                                              snapshot5
                                                                  .data!.length;
                                                          i++) {
                                                        allCoins.add(snapshot5
                                                            .data![i]['symbol']
                                                            .toString()
                                                            .toUpperCase());
                                                      }

                                                      for (int i = 0;
                                                          i <
                                                              snapshot5
                                                                  .data!.length;
                                                          i++) {
                                                        allIds.add(snapshot5
                                                            .data![i]['id']
                                                            .toString());
                                                      }

                                                      if (snapshot5.hasData) {
                                                        return FutureBuilder(
                                                            future: widget
                                                                .allCoins6,
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot
                                                                    snapshot6) {
                                                              for (int i = 0;
                                                                  i <
                                                                      snapshot6
                                                                          .data!
                                                                          .length;
                                                                  i++) {
                                                                allCoins.add(snapshot6
                                                                    .data![i][
                                                                        'symbol']
                                                                    .toString()
                                                                    .toUpperCase());
                                                              }

                                                              for (int i = 0;
                                                                  i <
                                                                      snapshot6
                                                                          .data!
                                                                          .length;
                                                                  i++) {
                                                                allIds.add(snapshot6
                                                                    .data![i]
                                                                        ['id']
                                                                    .toString());
                                                              }

                                                              if (snapshot6
                                                                  .hasData) {
                                                                return FutureBuilder(
                                                                    future: widget
                                                                        .allCoins7,
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot
                                                                            snapshot7) {
                                                                      for (int i =
                                                                              0;
                                                                          i < snapshot7.data!.length;
                                                                          i++) {
                                                                        allCoins.add(snapshot7
                                                                            .data![i]['symbol']
                                                                            .toString()
                                                                            .toUpperCase());
                                                                      }

                                                                      for (int i =
                                                                              0;
                                                                          i < snapshot7.data!.length;
                                                                          i++) {
                                                                        allIds.add(snapshot7
                                                                            .data![i]['id']
                                                                            .toString());
                                                                      }

                                                                      if (snapshot7
                                                                          .hasData) {
                                                                        return FutureBuilder(
                                                                            future:
                                                                                widget.allCoins8,
                                                                            builder: (BuildContext context, AsyncSnapshot snapshot8) {
                                                                              for (int i = 0; i < snapshot8.data!.length; i++) {
                                                                                allCoins.add(snapshot8.data![i]['symbol'].toString().toUpperCase());
                                                                              }

                                                                              for (int i = 0; i < snapshot8.data!.length; i++) {
                                                                                allIds.add(snapshot8.data![i]['id'].toString());
                                                                              }

                                                                              if (snapshot1.hasData) {
                                                                                return FutureBuilder(
                                                                                    future: widget.allCoins9,
                                                                                    builder: (BuildContext context, AsyncSnapshot snapshot9) {
                                                                                      for (int i = 0; i < snapshot9.data!.length; i++) {
                                                                                        allCoins.add(snapshot9.data![i]['symbol'].toString().toUpperCase());
                                                                                      }

                                                                                      for (int i = 0; i < snapshot9.data!.length; i++) {
                                                                                        allIds.add(snapshot9.data![i]['id'].toString());
                                                                                      }

                                                                                      if (snapshot9.hasData) {
                                                                                        return FutureBuilder(
                                                                                            future: widget.allCoins10,
                                                                                            builder: (BuildContext context, AsyncSnapshot snapshot10) {
                                                                                              for (int i = 0; i < snapshot10.data!.length; i++) {
                                                                                                allCoins.add(snapshot10.data![i]['symbol'].toString().toUpperCase());
                                                                                              }

                                                                                              for (int i = 0; i < snapshot10.data!.length; i++) {
                                                                                                allIds.add(snapshot10.data![i]['id'].toString());
                                                                                              }
                                                                                              //(allCoins.length);
                                                                                              //print(allIds.length);
                                                                                              if (snapshot10.hasData) {
                                                                                                return Center(
                                                                                                  child: InkWell(
                                                                                                    onTap: () => showSearch(
                                                                                                      context: context,
                                                                                                      delegate: MySearchDelegate(
                                                                                                        allCoins: allCoins,
                                                                                                        allIds: allIds,
                                                                                                      ),
                                                                                                    ),
                                                                                                    splashColor: Colors.transparent,
                                                                                                    splashFactory: NoSplash.splashFactory,
                                                                                                    child: Icon(
                                                                                                      CupertinoIcons.search,
                                                                                                      color: AppColors.navy,
                                                                                                      size: Get.width * 0.05,
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              } else if (snapshot10.hasError) {
                                                                                                return Container();
                                                                                              }
                                                                                              return Container();
                                                                                            });
                                                                                      } else if (snapshot9.hasError) {
                                                                                        return Container();
                                                                                      }
                                                                                      return Container();
                                                                                    });
                                                                              } else if (snapshot8.hasError) {
                                                                                return Container();
                                                                              }
                                                                              return Container();
                                                                            });
                                                                      } else if (snapshot7
                                                                          .hasError) {
                                                                        return Container();
                                                                      }
                                                                      return Container();
                                                                    });
                                                              } else if (snapshot6
                                                                  .hasError) {
                                                                return Container();
                                                              }
                                                              return Container();
                                                            });
                                                      } else if (snapshot5
                                                          .hasError) {
                                                        return Container();
                                                      }
                                                      return Container();
                                                    });
                                              } else if (snapshot4.hasError) {
                                                return Container();
                                              }
                                              return Container();
                                            });
                                      } else if (snapshot3.hasError) {
                                        return Container();
                                      }
                                      return Container();
                                    });
                              } else if (snapshot1.hasError) {
                                return Container();
                              }
                              return Container();
                            });
                      } else if (snapshot1.hasError) {
                        return Container();
                      }
                      return Container();
                    }),
                SizedBox(height: Get.height * 0.025),
                GeneralParent(
                  cryptoMarketGeneralViewSnapshot:
                      widget.cryptoMarketGeneralViewSnapshot,
                  cryptoMarketCapSnapshot: widget.cryptoMarketCapSnapshot,
                ),
                SizedBox(height: Get.height * 0.02),
                FearMeterParent(
                  dailyFearIndexSnapshot: widget.dailyFearIndexSnapshot,
                  weeklyFearIndexSanpshot: widget.weeklyFearIndexSanpshot,
                  monthlyFearIndexSnapshot: widget.monthlyFearIndexSnapshot,
                ),
                SizedBox(height: Get.height * 0.02),
                TopGainersAndLosersParent(
                  topGainersAndLosersSnapshot:
                      widget.topGainersAndLosersSnapshot,
                ),
                SizedBox(height: Get.height * 0.05),
                Top1000CoinsWidget(
                  top1000CoinsByMarketCap: widget.top1000CoinsByMarketCap,
                ),
              ],
            ),
          );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> allCoins;
  List<String> allIds;
  MySearchDelegate({required this.allCoins, required this.allIds});

  @override
  String get searchFieldLabel => 'Search bt ticker..';

  @override
  Widget? buildLeading(BuildContext context) => InkWell(
        onTap: () => close(context, null),
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Icon(
          CupertinoIcons.chevron_back,
          color: AppColors.navy,
          size: Get.width * 0.04,
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: InkWell(
            onTap: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Icon(
              CupertinoIcons.xmark,
              color: AppColors.lightGrey,
              size: Get.width * 0.04,
            ),
          ),
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: TextStyle(
            color: AppColors.navy,
            fontSize: Get.width * 0.04,
            letterSpacing: 1,
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = allCoins.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        List allCoinsLowerCase = allCoins.map((e) => e.toLowerCase()).toList();
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            int idIndex = allCoinsLowerCase.indexOf(query.toLowerCase());
            String id = allIds[idIndex];
            Get.to(
              () => CoinDetailsScreen(
                title: query.toUpperCase(),
                id: id,
              ),
            );
          },
        );
      },
    );
  }
}
