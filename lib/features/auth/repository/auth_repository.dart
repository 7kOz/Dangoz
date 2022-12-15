import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/repositories/firebase_storage_repository.dart';
import 'package:dangoz/features/auth/screens/otp_screen.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl_standalone.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getCurrentUserData() async {
    print('test');
    var userData =
        await firestore.collection('Users').doc(auth.currentUser?.uid).get();
    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void singUpWithEmailAndPassword(String email, String password, String name,
      String userName, String birthday) async {
    UserCredential user;
    try {
      user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      saveUserDataToFirebaseFromEmailSignUpInit(
          uid: user.user!.uid,
          email: email,
          name: name,
          userName: userName,
          birthday: birthday);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Oops',
        e.message!,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  void saveUserDataToFirebaseFromEmailSignUpInit({
    required String uid,
    required String email,
    required String name,
    required String userName,
    required String birthday,
  }) async {
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      List<String> deviceInfo = [];
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        deviceInfo.add(androidDeviceInfo.device);
        deviceInfo.add(androidDeviceInfo.manufacturer);
        deviceInfo.add(androidDeviceInfo.model);
      } else {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo.add(iosDeviceInfo.model as String);
        deviceInfo.add(iosDeviceInfo.utsname.machine.toString());
        deviceInfo.add(iosDeviceInfo.systemName as String);
        deviceInfo.add(iosDeviceInfo.systemVersion as String);
      }

      final defaultLocale = await findSystemLocale();
      var user = UserModel(
        uid: uid,
        email: email.toLowerCase(),
        name: name,
        userName: userName.toLowerCase(),
        birthday: birthday,
        phoneNumber: '',
        isPrivate: false,
        location: '',
        profileImage: '',
        isPro: false,
        isVerified: false,
        followers: 0,
        following: 0,
        joined: DateTime.now(),
        bio: '',
        isOnline: true,
        groupdId: [],
        deviceLocale: defaultLocale,
        deviceData: deviceInfo,
        isProTill: DateTime.parse('1995-09-23'),
        autoRenew: false,
        generalPosts: 0,
        newsPosts: 0,
        ideasPosts: 0,
        signalPosts: 0,
        memePosts: 0,
        forexGeneralPosts: 0,
        cryptoGeneralPosts: 0,
        stocksGeneralPosts: 0,
        forexNewsPosts: 0,
        cryptoNewsPosts: 0,
        stocksNewsPosts: 0,
        forexIdeasPosts: 0,
        cryptoIdeasPosts: 0,
        stocksIdeasPosts: 0,
        forexSignalsPosts: 0,
        cryptoSignalsPosts: 0,
        stocksSignalsPosts: 0,
        forexMemesPosts: 0,
        cryptoMemesPosts: 0,
        stocksMemesPosts: 0,
      );
      firestore.collection('Users').doc(uid).set(user.toMap());
      await firestore.collection('NotifiBool').doc(uid).set({
        'newNotif': false,
      });
    } catch (e) {
      Get.snackbar(
        'Oops',
        e.toString(),
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  void signInWithPhone(String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          Get.snackbar(
            'Oops',
            firebaseAuthException.message!,
            backgroundColor: AppColors.red,
          );
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Get.to(
            () => OTPScreen(
              verificationId: verificationId,
            ),
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Oops',
        e.message!,
        backgroundColor: AppColors.red,
      );
    }
  }

  void verifyOtp({
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Get.offAllNamed('/navbarScreen');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Oops',
        e.message!,
        backgroundColor: AppColors.red,
      );
    }
  }

  //Save User Init Data After Sigining In With Phone
  void saveUserDataToFirebaseFromPhoneSignInInit({
    required String email,
    required String name,
    required String userName,
    required String birthday,
    required ProviderRef ref,
  }) async {
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      List<String> deviceInfo = [];
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        deviceInfo.add(androidDeviceInfo.device);
        deviceInfo.add(androidDeviceInfo.manufacturer);
        deviceInfo.add(androidDeviceInfo.model);
      } else {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo.add(iosDeviceInfo.model as String);
        deviceInfo.add(iosDeviceInfo.utsname.machine.toString());
        deviceInfo.add(iosDeviceInfo.systemName as String);
        deviceInfo.add(iosDeviceInfo.systemVersion as String);
      }

      final defaultLocale = await findSystemLocale();
      String uid = auth.currentUser!.uid;
      DateTime joined = auth.currentUser!.metadata.creationTime as DateTime;
      String phoneNumber = auth.currentUser!.phoneNumber.toString();
      String photoUrl = '';

      //Check if image is not null and add it to firestorage and firebase
      // if (profileImage != null) {
      //   photoUrl = await ref
      //       .read(commonFirebaseStorageRepositoryProvider)
      //       .storeFileToFirebase(
      //         'profilePic/$uid',
      //         profileImage,
      //       );
      // }
      var user = UserModel(
        uid: uid,
        email: email.toLowerCase(),
        name: name,
        userName: userName.toLowerCase(),
        birthday: birthday,
        phoneNumber: phoneNumber,
        isPrivate: false,
        location: '',
        profileImage: photoUrl,
        isPro: false,
        isVerified: false,
        followers: 0,
        following: 0,
        joined: joined,
        bio: '',
        isOnline: true,
        groupdId: [],
        deviceLocale: defaultLocale,
        deviceData: deviceInfo,
        isProTill: DateTime.parse('1995-09-23'),
        autoRenew: false,
        generalPosts: 0,
        newsPosts: 0,
        ideasPosts: 0,
        signalPosts: 0,
        memePosts: 0,
        forexGeneralPosts: 0,
        cryptoGeneralPosts: 0,
        stocksGeneralPosts: 0,
        forexNewsPosts: 0,
        cryptoNewsPosts: 0,
        stocksNewsPosts: 0,
        forexIdeasPosts: 0,
        cryptoIdeasPosts: 0,
        stocksIdeasPosts: 0,
        forexSignalsPosts: 0,
        cryptoSignalsPosts: 0,
        stocksSignalsPosts: 0,
        forexMemesPosts: 0,
        cryptoMemesPosts: 0,
        stocksMemesPosts: 0,
      );
      firestore.collection('Users').doc(uid).set(user.toMap());
      await firestore.collection('NotifiBool').doc(uid).set({
        'newNotif': false,
      });
    } catch (e) {
      Get.snackbar(
        'Oops',
        e.toString(),
        backgroundColor: AppColors.red,
      );
    }
  }

  void setUserState(bool isOnline) async {
    await firestore.collection('Users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}
