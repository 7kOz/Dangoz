import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/buttons.dart';
import 'package:dangoz/base/utils.dart';
import 'package:dangoz/features/auth/controller/auth_controller.dart';
import 'package:dangoz/features/drawer/widgets/menu_widget.dart';
import 'package:dangoz/features/profile/controller/profile_controller.dart';
import 'package:dangoz/features/profile/screens/complete_sign_up_with_phonenumber_screen.dart';
import 'package:dangoz/features/profile/screens/followers_screen.dart';
import 'package:dangoz/features/profile/screens/followings_screen.dart';
import 'package:dangoz/features/profile/widgets/switch_to_private_popup.dart';
import 'package:dangoz/features/profile/widgets/switch_to_public_account.dart';
import 'package:dangoz/features/select_contacts/screens/select_contacts_by_phone_screen.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  File? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectProfileImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: ref
            .read(profileControllerProvider)
            .userDataById(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const SizedBox();
          }
          UserModel userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              title: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.navy,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width * 0.04,
                ),
              ),
              centerTitle: true,
              leading: const DrawerMenuWidget(),
            ),
            body: userData.userName != ''
                ? SingleChildScrollView(
                    child: Container(
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.025),
                          togglePrivacy(userData.isPrivate),
                          SizedBox(height: Get.height * 0.025),
                          findByContacts(),
                          profileImage(userData.profileImage as String),
                          SizedBox(height: Get.height * 0.025),
                          followingsAndFollowers(
                            userData.following,
                            userData.followers,
                          ),
                          SizedBox(height: Get.height * 0.025),
                          editProfile(),
                          SizedBox(height: Get.height * 0.025),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  userData.name,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: Get.width * 0.035,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '@${userData.userName}',
                                      style: TextStyle(
                                        color: AppColors.lightGrey,
                                        fontSize: Get.width * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Joined ${userData.joined.toString().substring(0, 10)}',
                                      style: TextStyle(
                                        color: AppColors.lightGrey,
                                        fontSize: Get.width * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.location,
                                      color: AppColors.grey,
                                      size: Get.width * 0.05,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      userData.location,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: Get.width * 0.03,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Divider(color: AppColors.lightGrey),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Dangoz Pro',
                                          style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        userData.isPro
                                            ? Icon(
                                                CupertinoIcons.check_mark,
                                                color: AppColors.green,
                                                size: Get.width * 0.05,
                                              )
                                            : Icon(
                                                CupertinoIcons.xmark,
                                                color: AppColors.red,
                                                size: Get.width * 0.05,
                                              ),
                                      ],
                                    ),
                                    !userData.isPro
                                        ? Container(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.35,
                                            decoration: BoxDecoration(
                                              color: AppColors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Upgrade To Pro',
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  letterSpacing: 1,
                                                  fontSize: Get.width * 0.035,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                'Renews ',
                                                style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: Get.width * 0.035,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                userData.isProTill
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                  color: AppColors.green,
                                                  fontSize: Get.width * 0.035,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Divider(color: AppColors.lightGrey),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.05),
                          SizedBox(height: Get.height * 0.15),
                        ],
                      ),
                    ),
                  )
                : const SingleChildScrollView(
                    child: CompleteSignUpWithPhoneNumberScreen(),
                  ),
          );
        });
  }

  Widget togglePrivacy(bool isPrivate) {
    return Center(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => isPrivate == true
                ? const SwitchToPublicPopUp()
                : const SwitchToPrivatePopUp(),
          );
        },
        child: Container(
          height: Get.height * 0.04,
          width: Get.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isPrivate == false ? AppColors.navy : AppColors.green,
          ),
          child: Center(
            child: Text(
              isPrivate == false ? 'Switch To Private' : 'Switch To Public',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: Get.width * 0.04,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget findByContacts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => const SelectContactsByPhoneScreen());
            },
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Icon(
              CupertinoIcons.person_add,
              color: AppColors.navy,
              size: Get.width * 0.06,
            ),
          ),
        ],
      ),
    );
  }

  Widget profileImage(String profileImage) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/dangozLogo.png',
              height: Get.height * 0.2,
            ),
          ),
          Visibility(
            visible: image != null,
            child: Positioned(
              left: Get.width * 0.1105,
              top: Get.height * 0.05,
              child: image != null
                  ? InkWell(
                      onTap: selectProfileImage,
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: CircleAvatar(
                        radius: Get.height * 0.05,
                        backgroundImage: FileImage(image!),
                      ),
                    )
                  : Container(),
            ),
          ),
          Visibility(
            visible: image == null,
            child: Positioned(
              left: Get.width * 0.1105,
              top: Get.height * 0.05,
              child: InkWell(
                onTap: selectProfileImage,
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: CircleAvatar(
                  radius: Get.height * 0.05,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.camera,
                    color: AppColors.lightGrey,
                    size: Get.width * 0.04,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget followingsAndFollowers(int following, int followers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: Get.height * 0.05,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Get.to(
                  () => const FollowingsScreen(),
                );
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Following'),
                  const SizedBox(height: 5),
                  Text(following.toString()),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => const FollowersScreen(),
                );
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Followers'),
                  const SizedBox(height: 5),
                  Text(followers.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Icon(
              CupertinoIcons.pencil,
              color: AppColors.navy,
              size: Get.width * 0.075,
            ),
          ),
        ],
      ),
    );
  }
}
