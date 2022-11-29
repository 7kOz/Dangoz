import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/screens/auth/login_screen.dart';
import 'package:dangoz/screens/auth/signup_screen.dart';
import 'package:dangoz/screens/crypto/crypto_navbar_screen.dart';
import 'package:dangoz/screens/gigs/add_gig_screen.dart';
import 'package:dangoz/screens/intro_screen.dart';
import 'package:dangoz/screens/notifications/user_notifications_screen.dart';
import 'package:dangoz/screens/profile/user_profile_screen.dart';
import 'package:dangoz/screens/forex/forex_navbar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    SignupScreen(),
    TestPyScreen(),
    CryptoNavbarScreen(),
    UserNotificationsScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        CupertinoIcons.dot_radiowaves_left_right,
        color: AppColors.white,
        size: 30,
      ),
      Icon(
        CupertinoIcons.money_dollar,
        color: AppColors.white,
        size: 30,
      ),
      Icon(
        CupertinoIcons.bitcoin,
        color: AppColors.white,
        size: 30,
      ),
      FaIcon(
        FontAwesomeIcons.moneyBillTrendUp,
        color: AppColors.white,
        size: 28,
      ),
      Icon(
        CupertinoIcons.person,
        color: AppColors.white,
        size: 30,
      ),
    ];

    return Container(
      color: AppColors.navy,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: AppColors.white,
            body: screens[index],
            bottomNavigationBar: CurvedNavigationBar(
              key: navigationKey,
              items: items,
              backgroundColor: Colors.transparent,
              color: AppColors.navy,
              buttonBackgroundColor: AppColors.green,
              height: 60,
              index: index,
              onTap: (index) => setState(() => this.index = index),
            ),
          ),
        ),
      ),
    );
  }
}
