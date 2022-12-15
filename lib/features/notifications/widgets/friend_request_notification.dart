import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/notifications/controller/notifications_controller.dart';
import 'package:dangoz/features/profiles/screens/profiles_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class FriendRequestNotification extends ConsumerWidget {
  String uid;
  String title;
  String notificationId;
  Timestamp notifcationDate;
  FriendRequestNotification({
    super.key,
    required this.uid,
    required this.title,
    required this.notificationId,
    required this.notifcationDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(notificationsControllerProvider).userDataById(uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const SizedBox();
          }
          return Container(
            height: Get.height * 0.1,
            width: Get.width,
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                snapshot.data['profileImage'] == ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProfilesScreen(profileId: uid));
                          },
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.navy,
                            child: Center(
                              child: Icon(
                                CupertinoIcons.person,
                                size: Get.width * 0.05,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProfilesScreen(profileId: uid));
                          },
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              snapshot.data['profileImage'],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.74,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                            child: Text(
                              '${snapshot.data['name']}',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${timeago.format(notifcationDate.toDate(), locale: 'en_short')} ${timeago.format(notifcationDate.toDate(), locale: 'en_short') == 'now' ? '' : 'ago'}',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 4),
                      child: Text(
                        '@${snapshot.data['userName']}',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.74,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => ref
                                .read(notificationsControllerProvider)
                                .declineFriendRequest(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  notificationId,
                                ),
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: Container(
                              width: Get.width * 0.35,
                              height: Get.height * 0.038,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.red),
                              child: Center(
                                  child: Text(
                                'Decline',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Get.width * 0.03,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () => ref
                                .read(notificationsControllerProvider)
                                .acceptFriendRequest(
                                  uid,
                                  notificationId,
                                ),
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: Container(
                              width: Get.width * 0.35,
                              height: Get.height * 0.038,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.green,
                              ),
                              child: Center(
                                  child: Text(
                                'Accept',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Get.width * 0.03,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
