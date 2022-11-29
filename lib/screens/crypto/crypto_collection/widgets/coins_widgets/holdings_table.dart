import 'dart:convert';

import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class HoldingsTable extends StatefulWidget {
  dynamic dummyData = [
    {
      'dbId': 'bitTrans',
      'id': 'bitcoin',
      'symbol': 'btc',
      'holding': 0.05,
      'broughtAt': 15000.5,
      'date': '2022 - 10 - 15',
    },
    {
      'dbId': 'ethTrans',
      'id': 'ethereum',
      'symbol': 'eth',
      'holding': 1.2,
      'broughtAt': 3010.55,
      'date': '2021 - 09 - 1',
    },
  ];

  HoldingsTable({Key? key}) : super(key: key);

  @override
  State<HoldingsTable> createState() => _HoldingsTableState();
}

class _HoldingsTableState extends State<HoldingsTable> {
  List<dynamic> snapshotsList = [];
  List<dynamic> sortedDummy = [];
  List<double> totalPl = [];

  @override
  void initState() {
    super.initState();
    prepareData();
  }

  @override
  Widget build(BuildContext context) {
    sortedDummy.clear();
    totalPl.clear();
    setState(() {});
    for (int index = 0; index < snapshotsList.length; index++) {
      String dbId = widget.dummyData[index]['dbId'].toString();
      String tDate = widget.dummyData[index]['date'].toString();
      String image = snapshotsList[index]['image']['thumb'];
      String ticker = snapshotsList[index]['symbol'].toString().toUpperCase();
      double holding = widget.dummyData[index]['holding'] ?? 0.0;
      String formattedHolding = holding.toString();
      double currentPrice =
          snapshotsList[index]['market_data']['current_price']['usd'] ?? 0.0;
      String formattedCurrentPrice =
          NumberFormat.compact().format(currentPrice);
      double holdingInDollar = holding * currentPrice;
      String formattedHoldingInDollar =
          NumberFormat.compact().format(holdingInDollar);
      String priceChangeIn24 = snapshotsList[index]['market_data']
              ['price_change_percentage_24h']
          .toString()
          .substring(0, 4);

      String buyPrice = widget.dummyData[index]['broughtAt'].toString();

      double pl = holdingInDollar -
          (widget.dummyData[index]['broughtAt'] *
              widget.dummyData[index]['holding']);

      double totalHoldings = 0.0;
      for (int i = 0; i < snapshotsList.length; i++) {
        totalHoldings += (widget.dummyData[i]['holding'] *
            snapshotsList[i]['market_data']['current_price']['usd']);
      }
      double percentageHolding = (holdingInDollar / totalHoldings) * 100;
      String formattedPercentageHolding =
          percentageHolding.toString().substring(0, 4);

      sortedDummy.add({
        'dbId': dbId,
        'date': tDate,
        'image': image,
        'ticker': ticker,
        'formattedHolding': formattedHolding,
        'formattedHoldingInDollar': formattedHoldingInDollar,
        'currentPrice': currentPrice.toString().substring(0, 7),
        'priceChangeIn24': priceChangeIn24,
        'buyPrice': buyPrice,
        'pl': pl.toString().substring(0, 7),
        'formattedPercentageHolding': formattedPercentageHolding,
        'totalPl': pl,
      });

      sortedDummy = sortedDummy
        ..sort((a, b) => double.parse(b['formattedHolding'])
            .compareTo(double.parse(a['formattedHolding'])));
    }
    for (int i = 0; i < sortedDummy.length; i++) {
      totalPl.add(sortedDummy[i]['totalPl']);
    }

    return Column(
      children: [
        Container(
          height: Get.height * 0.75,
          width: Get.width,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      'Transactions',
                      style: TextStyle(
                          color: AppColors.white, fontSize: Get.width * 0.04),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'P ',
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: Get.width * 0.04),
                        ),
                        Text(
                          '/',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.04),
                        ),
                        Text(
                          ' L',
                          style: TextStyle(
                              color: AppColors.red, fontSize: Get.width * 0.04),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      totalPl.length < 2
                          ? '\$${totalPl.sum.toString().substring(0, 3)}'
                          : '\$${totalPl.sum.toString().substring(0, 8)}',
                      style: TextStyle(
                          color: totalPl.sum.toString()[0] == '-'
                              ? AppColors.red
                              : AppColors.green,
                          fontSize: Get.width * 0.04),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              header(),
              SizedBox(height: Get.height * 0.01),
              Container(
                height: Get.height * 0.4,
                width: Get.width,
                child: ListView.builder(
                  itemCount: snapshotsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return footer(
                      sortedDummy[index]['dbId'],
                      sortedDummy[index]['image'],
                      sortedDummy[index]['ticker'],
                      sortedDummy[index]['formattedHolding'],
                      sortedDummy[index]['formattedHoldingInDollar'],
                      sortedDummy[index]['currentPrice'],
                      sortedDummy[index]['priceChangeIn24'],
                      sortedDummy[index]['buyPrice'],
                      sortedDummy[index]['pl'],
                      sortedDummy[index]['formattedPercentageHolding'],
                      sortedDummy[index]['date'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget header() {
    return Container(
      height: Get.height * 0.1,
      width: Get.width,
      color: AppColors.navy,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: Get.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ticker',
                    style: TextStyle(
                        color: AppColors.white, fontSize: Get.width * 0.0325),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Holding',
                    style: TextStyle(
                        color: AppColors.white, fontSize: Get.width * 0.0325),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Holding in \$',
                    style: TextStyle(
                        color: AppColors.white, fontSize: Get.width * 0.0325),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: AppColors.white,
            ),
            Container(
              width: Get.width * 0.225,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Current Price',
                      style: TextStyle(
                          color: AppColors.white, fontSize: Get.width * 0.0325),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '24h %',
                      style: TextStyle(
                          color: AppColors.white, fontSize: Get.width * 0.0325),
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
                      'Buy Price',
                      style: TextStyle(
                          color: AppColors.white, fontSize: Get.width * 0.0325),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'P ',
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: Get.width * 0.0325),
                        ),
                        Text(
                          '/',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0325),
                        ),
                        Text(
                          ' L',
                          style: TextStyle(
                              color: AppColors.red,
                              fontSize: Get.width * 0.0325),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: AppColors.white,
            ),
            Container(
              width: Get.width * 0.12,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '%',
                      style: TextStyle(
                          color: AppColors.white, fontSize: Get.width * 0.0325),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget footer(
    String dbId,
    image,
    ticker,
    formattedHolding,
    formattedHoldingInDollar,
    currentPrice,
    priceChangeIn24,
    buyPrice,
    pl,
    formattedPercentageHolding,
    tDate,
  ) {
    return Column(
      children: [
        Container(
          height: Get.height * 0.1,
          width: Get.width,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        image,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        width: Get.width * 0.12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticker,
                              style: TextStyle(
                                  color: AppColors.navy,
                                  fontSize: Get.width * 0.0325),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              formattedHolding,
                              style: TextStyle(
                                  color: AppColors.navy,
                                  fontSize: Get.width * 0.0325),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '\$$formattedHoldingInDollar',
                              style: TextStyle(
                                  color: AppColors.green,
                                  fontSize: Get.width * 0.0325),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: AppColors.lightGrey,
                ),
                Container(
                  width: Get.width * 0.225,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$$currentPrice',
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: Get.width * 0.0325),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$priceChangeIn24 %',
                          style: TextStyle(
                              color: priceChangeIn24[0] == '-'
                                  ? AppColors.red
                                  : AppColors.green,
                              fontSize: Get.width * 0.0325),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: AppColors.lightGrey,
                ),
                Container(
                  width: Get.width * 0.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$$buyPrice',
                          style: TextStyle(
                              color: AppColors.navy,
                              fontSize: Get.width * 0.0325),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$$pl',
                          style: TextStyle(
                              color: pl[0] == '-'
                                  ? AppColors.red
                                  : AppColors.green,
                              fontSize: Get.width * 0.0325),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: AppColors.lightGrey,
                ),
                Container(
                  width: Get.width * 0.12,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$formattedPercentageHolding %',
                          style: TextStyle(
                              color: AppColors.navy,
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
        Divider(color: AppColors.lightGrey),
        Center(
          child: SizedBox(
            height: Get.height * 0.02,
            child: Text(
              tDate,
              style: TextStyle(
                  color: AppColors.navy, fontSize: Get.width * 0.0325),
            ),
          ),
        ),
        Divider(color: AppColors.lightGrey),
      ],
    );
  }

  prepareData() async {
    for (int i = 0; i < widget.dummyData.length; i++) {
      Map<String, dynamic> snapshot =
          await getCoinData(widget.dummyData[i]['id']);
      snapshotsList.add(snapshot);
    }
  }

  Future getCoinData(String id) async {
    final queryParameters = {
      'localization': 'true',
      'tickers': 'true',
      'market_data': 'true',
      'community_data': 'true',
      'developer_data': 'true',
      'sparkline': 'false'
    };

    final uri = Uri.https(
      'www.coingecko.p.rapidapi.com',
      '/coins/$id',
      queryParameters,
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd010aaf82msh48a2174c81c091ep1cb4fajsnca576b1914d4',
      'X-RapidAPI-Host': 'coingecko.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      //print(response.body);
      print('done');
      return jsonDecode(response.body);
    } else {
      print('not done');
      throw Exception('Failed to load');
    }
  }
}
