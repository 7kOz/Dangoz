import 'dart:async';
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dangoz/apis/crypto_apis/general_crypto_api.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/models/econimoc_calendar_model.dart';
import 'package:dangoz/screens/auth/signup_screen.dart';
import 'package:dangoz/screens/crypto/crypto_collection/screens/crypto_chart_screen.dart';
import 'package:dangoz/screens/crypto/crypto_collection/screens/crypto_collections_screen.dart';
import 'package:dangoz/screens/crypto/crypto_collection/screens/crypto_feed_screen.dart';
import 'package:dangoz/screens/crypto/crypto_collection/screens/crypto_wallet_screen.dart';
import 'package:dangoz/screens/forex/forex_calendar_screen.dart';
import 'package:dangoz/screens/forex/forex_chart_screen.dart';
import 'package:dangoz/screens/forex/forex_feed_screen.dart';
import 'package:dangoz/screens/forex/forex_wallet_screen.dart';
import 'package:dangoz/screens/gigs/add_gig_screen.dart';
import 'package:dangoz/screens/notifications/user_notifications_screen.dart';
import 'package:dangoz/screens/profile/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class CryptoNavbarScreen extends StatefulWidget {
  bool? loading;
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
  CryptoNavbarScreen({
    Key? key,
    this.loading,
    this.cryptoMarketGeneralViewSnapshot,
    this.cryptoMarketCapSnapshot,
    this.dailyFearIndexSnapshot,
    this.weeklyFearIndexSanpshot,
    this.monthlyFearIndexSnapshot,
    this.topGainersAndLosersSnapshot,
    this.top1000CoinsByMarketCap,
    this.allCoins1,
    this.allCoins2,
    this.allCoins3,
    this.allCoins4,
    this.allCoins5,
    this.allCoins6,
    this.allCoins7,
    this.allCoins8,
    this.allCoins9,
    this.allCoins10,
    this.exchanges,
    this.cryptoNews,
    this.trendingCryptoMentions,
    this.bullishCryptoMentions,
    this.bearishCryptoMentions,
  }) : super(key: key);

  @override
  State<CryptoNavbarScreen> createState() => _CryptoNavbarScreenState();
}

class _CryptoNavbarScreenState extends State<CryptoNavbarScreen> {
  @override
  void initState() {
    super.initState();

    widget.loading = true;
    widget.cryptoMarketGeneralViewSnapshot =
        GeneralCryptoApi().getCryptoMarketGeneralView();
    widget.cryptoMarketCapSnapshot = GeneralCryptoApi().getCryptoMarketCap();
    widget.dailyFearIndexSnapshot = GeneralCryptoApi().getDailyFearIndex();
    widget.weeklyFearIndexSanpshot = GeneralCryptoApi().getWeeklyFearIndex();
    widget.monthlyFearIndexSnapshot = GeneralCryptoApi().getMonthlyFearIndex();
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
    widget.exchanges = GeneralCryptoApi().getExchanges();
    widget.cryptoNews = GeneralCryptoApi().getImportantCryptoNews();
    widget.trendingCryptoMentions =
        GeneralCryptoApi().getTrendingCyptoMentions('24h');
    widget.bullishCryptoMentions =
        GeneralCryptoApi().getBullishCryptoMentions('24h');
    widget.bearishCryptoMentions =
        GeneralCryptoApi().getBearishCryptoMentions('24h');
  }

  @override
  void dispose() {
    super.dispose();
  }

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  @override
  Widget build(BuildContext context) {
    final screens = [
      CryptoWalletScreen(),
      CryptoCollectionsScreen(
        loading: true,
        cryptoMarketGeneralViewSnapshot: widget.cryptoMarketGeneralViewSnapshot,
        cryptoMarketCapSnapshot: widget.cryptoMarketCapSnapshot,
        dailyFearIndexSnapshot: widget.dailyFearIndexSnapshot,
        weeklyFearIndexSanpshot: widget.weeklyFearIndexSanpshot,
        monthlyFearIndexSnapshot: widget.monthlyFearIndexSnapshot,
        topGainersAndLosersSnapshot: widget.topGainersAndLosersSnapshot,
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
        exchanges: widget.exchanges,
        cryptoNews: widget.cryptoNews,
        trendingCryptoMentions: widget.trendingCryptoMentions,
        bullishCryptoMentions: widget.bullishCryptoMentions,
        bearishCryptoMentions: widget.bearishCryptoMentions,
      ),
      CryptoChartScreen(),
      CryptoFeedScreen(),
    ];
    final items = <Widget>[
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(math.pi),
        child: FaIcon(
          FontAwesomeIcons.wallet,
          color: AppColors.white,
          size: 28,
        ),
      ),
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(math.pi),
        child: Icon(
          CupertinoIcons.collections,
          color: AppColors.white,
          size: 30,
        ),
      ),
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(math.pi),
        child: FaIcon(
          FontAwesomeIcons.chartLine,
          color: AppColors.white,
          size: 28,
        ),
      ),
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(math.pi),
        child: Icon(
          CupertinoIcons.dot_radiowaves_left_right,
          color: AppColors.white,
          size: 30,
        ),
      ),
    ];

    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: true,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Container(
                  height: Get.height * 0.07073,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(math.pi),
                    child: CurvedNavigationBar(
                      key: navigationKey,
                      items: items,
                      backgroundColor: Colors.transparent,
                      color: AppColors.navy,
                      buttonBackgroundColor: AppColors.green,
                      height: 50,
                      index: index,
                      onTap: (index) => setState(() => this.index = index),
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.777,
                  width: Get.width,
                  child: screens[index],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
