import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HoldingsChartCarousel extends StatefulWidget {
  const HoldingsChartCarousel({Key? key}) : super(key: key);

  @override
  State<HoldingsChartCarousel> createState() => _HoldingsChartCarouselState();
}

class _HoldingsChartCarouselState extends State<HoldingsChartCarousel> {
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

  dynamic snapshotsList = [];

  @override
  void initState() async {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      width: Get.width,
    );
  }
}

// prepareData(List dummyData) async {
//   List data = [];

//   for (int i = 0; i < dummyData.length; i++) {
//     Map<String, dynamic> snapshot =
//         await getCoinMarketChart24H(dummyData[i]['id']);
//   }

//   return data;
// }

Future getCoinMarketChart24H(String id) async {
  final queryParameters = {
    'vs_currency': 'usd',
    'days': '1',
  };

  final uri = Uri.https(
    'www.coingecko.p.rapidapi.com',
    '/coins/$id/market_chart',
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


//  HoldingsChart24(
//                     chartTitle: 'BTC',
//                     low: 24.toString(),
//                     high: 70.toString(),
//                     priceList: [
//                       1,
//                       2,
//                       3,
//                       4,
//                       5,
//                       6,
//                       7,
//                       8,
//                       8,
//                       9,
//                       0,
//                       1,
//                       12,
//                       3,
//                       4,
//                       5,
//                       5,
//                       3,
//                       3,
//                       3,
//                       3,
//                       3,
//                       2,
//                       2,
//                       5,
//                     ]),