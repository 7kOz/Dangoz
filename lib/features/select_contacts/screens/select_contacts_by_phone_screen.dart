import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/chat/screens/chat_screen.dart';
import 'package:dangoz/features/select_contacts/controller/select_contact_controller.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class SelectContactsByPhoneScreen extends ConsumerWidget {
  const SelectContactsByPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.075),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Icon(
                        CupertinoIcons.chevron_back,
                        color: AppColors.navy,
                        size: Get.width * 0.075,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.05),
                TabBar(
                  labelColor: AppColors.navy,
                  splashFactory: NoSplash.splashFactory,
                  splashBorderRadius: BorderRadius.zero,
                  unselectedLabelColor: AppColors.lightGrey,
                  indicatorColor: AppColors.green,
                  labelPadding: const EdgeInsets.symmetric(vertical: 4),
                  labelStyle: TextStyle(
                    letterSpacing: 1,
                    fontSize: Get.width * 0.04,
                  ),
                  tabs: const [
                    Text('Suggestions'),
                    Text('Find Friends'),
                  ],
                ),
                SizedBox(height: Get.height * 0.025),
                SizedBox(
                  height: Get.height * 0.75,
                  child: TabBarView(
                    children: [
                      Center(
                        child: Text('sugg'),
                      ),
                      phoneContacts(ref),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneContacts(WidgetRef ref) {
    return ref.watch(getContactsProvicer).when(
          data: (contactList) => contactList.isNotEmpty
              ? Center(
                  child: Container(
                    height: Get.height * 0.75,
                    width: Get.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: contactList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(contactList[i])
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Material(
                                    elevation: 5,
                                    shadowColor: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      height: Get.height * 0.225,
                                      width: Get.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.navy,
                                        border:
                                            Border.all(color: AppColors.navy),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                snapshot.data['profileImage'] ==
                                                        ''
                                                    ? CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            AppColors.white,
                                                        child: Center(
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .person,
                                                            color: AppColors
                                                                .lightGrey,
                                                          ),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            AppColors.white,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          snapshot.data[
                                                              'profileImage'],
                                                        ),
                                                      ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data['name'],
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize:
                                                            Get.width * 0.035,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      '@${snapshot.data['userName']}',
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize:
                                                            Get.width * 0.03,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: Get.height * 0.04,
                                                      width: Get.width * 0.3,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color:
                                                              AppColors.white),
                                                      child: Center(
                                                        child: Text(
                                                          'Follow',
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.navy,
                                                            letterSpacing: 1,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02),
                                            Text(
                                              'This Is my bio',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: AppColors.lightGrey,
                                                  fontSize: Get.width * 0.03),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.chat_bubble,
                                                  color: Colors.transparent,
                                                ),
                                                LottieBuilder.asset(
                                                  'assets/animations/wavingHand.json',
                                                  height: Get.height * 0.065,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      ChatScreen(
                                                          name: snapshot
                                                              .data['name'],
                                                          uid: snapshot
                                                              .data['uid'])),
                                                  splashColor:
                                                      Colors.transparent,
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .chat_bubble_fill,
                                                    color: AppColors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              }
                              return SizedBox();
                            },
                          );
                        }),
                  ),
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Looks Lonely In Here',
                        style: TextStyle(
                            color: AppColors.navy,
                            fontWeight: FontWeight.w500,
                            fontSize: Get.width * 0.035),
                      ),
                      SizedBox(height: 10),
                      LottieBuilder.asset('assets/animations/ghost.json'),
                    ],
                  ),
                ),
          error: (err, trace) {
            return Container();
          },
          loading: () {
            return Container();
          },
        );
  }
}
