import 'dart:io';

import 'package:dangoz/screens/auth/login_screen.dart';
import 'package:dangoz/screens/auth/signup_screen.dart';
import 'package:dangoz/screens/gigs/add_gig_screen.dart';
import 'package:dangoz/screens/intro_screen.dart';
import 'package:dangoz/screens/navbar_screen.dart';
import 'package:dangoz/screens/notifications/user_notifications_screen.dart';
import 'package:dangoz/screens/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      title: 'Ability Consultancy',
      getPages: [
        GetPage(
          name: '/',
          page: () => const IntroScreen(),
        ),
        GetPage(
          name: '/signupScreen',
          page: () => SignupScreen(),
        ),
        GetPage(
          name: '/loginScreen',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/navbarScreen',
          page: () => const NavbarScreen(),
        ),
        GetPage(
          name: '/addGigScreen',
          page: () => const AddGigScreen(),
        ),
        GetPage(
          name: '/userNotificationsScreen',
          page: () => const UserNotificationsScreen(),
        ),
        GetPage(
          name: '/userProfileScreen',
          page: () => UserProfileScreen(),
        ),
      ],
    );
  }
}
