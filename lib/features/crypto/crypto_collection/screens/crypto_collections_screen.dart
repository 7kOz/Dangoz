import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/crypto/crypto_collection/screens/coins_screen.dart';
import 'package:dangoz/features/crypto/crypto_collection/screens/crypto_feed_screen.dart';
import 'package:dangoz/features/crypto/crypto_collection/screens/crypto_news_screen.dart';
import 'package:dangoz/features/crypto/crypto_collection/screens/crypto_socials_screen.dart';
import 'package:dangoz/features/crypto/crypto_collection/screens/exchanges_screen.dart';

import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator_ns/liquid_progress_indicator.dart';
import 'dart:convert';
import 'package:emojis/emojis.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CryptoCollectionsScreen extends StatefulWidget {
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
  dynamic exchanges;
  dynamic cryptoNews;
  dynamic trendingCryptoMentions;
  dynamic bullishCryptoMentions;
  dynamic bearishCryptoMentions;
  CryptoCollectionsScreen({
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
    required this.exchanges,
    required this.cryptoNews,
    required this.trendingCryptoMentions,
    required this.bullishCryptoMentions,
    required this.bearishCryptoMentions,
  }) : super(key: key);

  @override
  State<CryptoCollectionsScreen> createState() =>
      _CryptoCollectionsScreenState();
}

class _CryptoCollectionsScreenState extends State<CryptoCollectionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            tabbars(),
            Container(
              height: Get.height * 0.74,
              width: Get.width,
              child: TabBarView(
                children: [
                  CoinsScreen(
                    loading: widget.loading,
                    cryptoMarketGeneralViewSnapshot:
                        widget.cryptoMarketGeneralViewSnapshot,
                    cryptoMarketCapSnapshot: widget.cryptoMarketCapSnapshot,
                    dailyFearIndexSnapshot: widget.dailyFearIndexSnapshot,
                    weeklyFearIndexSanpshot: widget.weeklyFearIndexSanpshot,
                    monthlyFearIndexSnapshot: widget.monthlyFearIndexSnapshot,
                    topGainersAndLosersSnapshot:
                        widget.topGainersAndLosersSnapshot,
                    top1000CoinsByMarketCap: widget.top1000CoinsByMarketCap,
                    allCoins1: widget.allCoins1,
                    allCoins2: widget.allCoins2,
                    allCoins3: widget.allCoins3,
                    allCoins4: widget.allCoins4,
                    allCoins5: widget.allCoins5,
                    allCoins6: widget.allCoins6,
                    allCoins7: widget.allCoins7,
                    allCoins8: widget.allCoins8,
                    allCoins9: widget.allCoins9,
                    allCoins10: widget.allCoins10,
                  ),
                  ExchangesScreen(exchangesSnapshot: widget.exchanges),
                  CryptoNewsScreen(cryptoNewsSnapshot: widget.cryptoNews),
                  CryptoSocialsScreen(
                    trendingCryptoMentions: widget.trendingCryptoMentions,
                    bullishCryptoMentions: widget.bullishCryptoMentions,
                    bearishCryptoMentions: widget.bearishCryptoMentions,
                  ),
                  CryptoFeedScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabbars() {
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: TabBar(
        labelStyle: TextStyle(
          color: AppColors.navy,
          fontSize: Get.width * 0.035,
        ),
        labelColor: AppColors.navy,
        indicatorColor: AppColors.green,
        unselectedLabelColor: AppColors.lightGrey,
        unselectedLabelStyle: TextStyle(
          color: AppColors.navy,
          fontSize: Get.width * 0.03,
        ),
        labelPadding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        tabs: const [
          Text('Coins'),
          Text('Exchanges'),
          Text('News'),
          Text('Socials'),
          Text('Corelations'),
        ],
      ),
    );
  }
}
