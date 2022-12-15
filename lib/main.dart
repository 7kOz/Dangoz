import 'dart:io';

import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:dangoz/features/auth/login_screen.dart';
import 'package:dangoz/features/auth/signup_screen.dart';
import 'package:dangoz/features/intro_screen.dart';
import 'package:dangoz/features/navbar_screen.dart';
import 'package:dangoz/features/notifications/user_notifications_screen.dart';
import 'package:dangoz/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      initialRoute: '/',
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      title: 'Ability Consultancy',
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          if (user == null) {
            return const IntroScreen();
          }
          return const NavbarScreen();
        },
        error: (err, trace) {
          return Container(
            child: Text(err.toString()),
          );
        },
        loading: () {
          return Center(
            child: SpinKitCubeGrid(color: AppColors.navy),
          );
        },
      ),
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
          name: '/userNotificationsScreen',
          page: () => const UserNotificationsScreen(),
        ),
      ],
    );
  }
}
