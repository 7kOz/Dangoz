import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:dangoz/features/auth/screens/verify_email_screen.dart';
import 'package:dangoz/features/chat/screens/all_chats_screen.dart';
import 'package:dangoz/features/crypto/crypto_navbar_screen.dart';
import 'package:dangoz/features/drawer/screens/drawer_screen.dart';
import 'package:dangoz/features/forex/forex_navbar_screen.dart';
import 'package:dangoz/features/notifications/user_notifications_screen.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavbarScreen extends ConsumerStatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends ConsumerState<NavbarScreen>
    with WidgetsBindingObserver {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  bool isEmailVerified = true;
  Timer? timer;
  int index = 0;
  UserModel? user;

  final screens = [
    DrawerScreen(),
    TestPyScreen(),
    CryptoNavbarScreen(),
    UserNotificationsScreen(),
    AllChatsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser!.email);
    WidgetsBinding.instance.addObserver(this);
    if (FirebaseAuth.instance.currentUser!.email != null) {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (!isEmailVerified) {
        sendVerificationEmail();
        timer = Timer.periodic(
          const Duration(seconds: 3),
          (_) => checkIfEmailIsVerified(),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  Future checkIfEmailIsVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

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
        CupertinoIcons.chat_bubble,
        color: AppColors.white,
        size: 28,
      ),
    ];

    return isEmailVerified
        ? Container(
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
          )
        : VerifyEmailScreen();
  }
}
