import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/notifications/controller/notifications_controller.dart';
import 'package:dangoz/features/posts/screens/post_details_screen.dart';
import 'package:dangoz/features/profiles/screens/profiles_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class DisLikedReplyToCommentNotification extends ConsumerWidget {
  String uid;
  String title;
  String notificationId;
  Timestamp notifcationDate;
  DisLikedReplyToCommentNotification({
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
          return FutureBuilder(
              future: ref
                  .read(notificationsControllerProvider)
                  .notificationFuture(notificationId),
              builder: (BuildContext context, AsyncSnapshot notifSnapshot) {
                if (notifSnapshot.data == null) {
                  return const SizedBox();
                }
                String postId = notifSnapshot.data['extraMessage'];
                String commentId = notifSnapshot.data['message'];
                String replyId = notifSnapshot.data['title'];
                return FutureBuilder(
                    future: ref
                        .read(notificationsControllerProvider)
                        .commentData(postId, commentId),
                    builder: (BuildContext context, AsyncSnapshot commentSnap) {
                      if (commentSnap.data == null) {
                        return const SizedBox();
                      }
                      return FutureBuilder(
                          future: ref
                              .read(notificationsControllerProvider)
                              .replyFuture(commentId, replyId),
                          builder:
                              (BuildContext context, AsyncSnapshot replySnap) {
                            if (replySnap.data == null) {
                              return const SizedBox();
                            }
                            return Column(
                              children: [
                                Container(
                                  height: Get.height * 0.15,
                                  width: Get.width,
                                  color: AppColors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      snapshot.data['profileImage'] == ''
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(() => ProfilesScreen(
                                                      profileId: uid));
                                                },
                                                splashColor: Colors.transparent,
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      AppColors.navy,
                                                  child: Center(
                                                    child: Icon(
                                                      CupertinoIcons.person,
                                                      size: Get.width * 0.05,
                                                      color:
                                                          AppColors.lightGrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Get.to(() => ProfilesScreen(
                                                    profileId: uid));
                                              },
                                              splashColor: Colors.transparent,
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data['profileImage'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.74,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 4),
                                                  child: Text(
                                                    '${snapshot.data['name']}',
                                                    style: TextStyle(
                                                      color: AppColors.navy,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    '${timeago.format(notifcationDate.toDate(), locale: 'en_short')} ${timeago.format(notifcationDate.toDate(), locale: 'en_short') == 'now' ? '' : 'ago'}',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 4),
                                            child: Text(
                                              '@${snapshot.data['userName']}',
                                              style: TextStyle(
                                                color: AppColors.navy,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Get.width * 0.75,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  splashColor:
                                                      Colors.transparent,
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  child: Container(
                                                    width: Get.width * 0.62,
                                                    height: Get.height * 0.04,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.navy,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: SizedBox(
                                                            width: Get.width *
                                                                0.56,
                                                            child: Text(
                                                              commentSnap.data[
                                                                  'comment'],
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    Get.width *
                                                                        0.03,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            width: Get.width * 0.75,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  splashColor:
                                                      Colors.transparent,
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  child: Container(
                                                    width: Get.width * 0.62,
                                                    height: Get.height * 0.04,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      border: Border.all(
                                                          width: 1.5,
                                                          color:
                                                              AppColors.navy),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: SizedBox(
                                                            width: Get.width *
                                                                0.56,
                                                            child: Text(
                                                              replySnap.data[
                                                                  'reply'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .navy,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    Get.width *
                                                                        0.03,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    width: Get.width * 0.1,
                                                    height: Get.height * 0.04,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.navy,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .hand_thumbsdown_fill,
                                                        color: AppColors.red,
                                                        size: Get.width * 0.05,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: AppColors.lightGrey,
                                  thickness: 0.5,
                                ),
                              ],
                            );
                          });
                    });
              });
        });
  }
}
