import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/models/econimoc_calendar_model.dart';
import 'package:dangoz/screens/auth/signup_screen.dart';
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

class TestPyScreen extends StatefulWidget {
  const TestPyScreen({Key? key}) : super(key: key);

  @override
  State<TestPyScreen> createState() => _TestPyScreenState();
}

class _TestPyScreenState extends State<TestPyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    ForexWalletScreen(),
    ForexCalendarScreen(),
    ForexChartScreen(),
    ForexFeedScreen()
  ];

  @override
  Widget build(BuildContext context) {
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
          CupertinoIcons.calendar,
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
      color: AppColors.navy,
      child: SafeArea(
        top: true,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Container(
                  height: Get.height * 0.07,
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
