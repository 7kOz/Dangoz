import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/notifications/controller/notifications_controller.dart';
import 'package:dangoz/features/notifications/widgets/accepted_request_notification.dart';
import 'package:dangoz/features/notifications/widgets/commented_on_your_post_notification.dart';
import 'package:dangoz/features/notifications/widgets/dislike_reply_to_comment_notification.dart';
import 'package:dangoz/features/notifications/widgets/disliked_your_post_notification.dart';
import 'package:dangoz/features/notifications/widgets/friend_request_notification.dart';
import 'package:dangoz/features/notifications/widgets/like_reply_to_comment_notification.dart';
import 'package:dangoz/features/notifications/widgets/liked_your_post_notification.dart';
import 'package:dangoz/features/notifications/widgets/replied_to_comment_notification.dart';
import 'package:dangoz/features/notifications/widgets/reposted_your_post_notification.dart';
import 'package:dangoz/features/notifications/widgets/started_following_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Icon(
              CupertinoIcons.chevron_back,
              color: AppColors.navy,
              size: Get.width * 0.06,
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: Get.width * 0.045,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.green,
              splashFactory: NoSplash.splashFactory,
              splashBorderRadius: BorderRadius.circular(0),
              labelColor: AppColors.navy,
              unselectedLabelColor: AppColors.lightGrey,
              labelPadding: const EdgeInsets.symmetric(vertical: 8),
              tabs: [
                Text(
                  'Social',
                  style: TextStyle(fontSize: Get.width * 0.035),
                ),
                Text(
                  'Friend Request',
                  style: TextStyle(fontSize: Get.width * 0.035),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.025),
            Container(
              height: Get.height * 0.8,
              child: TabBarView(
                children: [
                  StreamBuilder(
                    stream: ref
                        .read(notificationsControllerProvider)
                        .notificationsStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot notificationsSnapshot) {
                      if (notificationsSnapshot.data == null) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: Get.height * 0.8,
                        width: Get.width,
                        child: ListView.builder(
                          itemCount: notificationsSnapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int i) {
                            return notificationsSnapshot.data.docs[i]['type'] ==
                                    'likedPost'
                                ? LikedYourPostNotification(
                                    uid: notificationsSnapshot.data.docs[i]
                                        ['userUid'],
                                    title: notificationsSnapshot.data.docs[i]
                                        ['title'],
                                    notificationId: notificationsSnapshot
                                        .data.docs[i]['notificationId'],
                                    notifcationDate: notificationsSnapshot
                                        .data.docs[i]['sentAt'],
                                  )
                                : notificationsSnapshot.data.docs[i]['type'] ==
                                        'disLikedPost'
                                    ? DisLikedYourPostNotification(
                                        uid: notificationsSnapshot.data.docs[i]
                                            ['userUid'],
                                        title: notificationsSnapshot
                                            .data.docs[i]['title'],
                                        notificationId: notificationsSnapshot
                                            .data.docs[i]['notificationId'],
                                        notifcationDate: notificationsSnapshot
                                            .data.docs[i]['sentAt'],
                                      )
                                    : notificationsSnapshot.data.docs[i]
                                                ['type'] ==
                                            'commentedOnPost'
                                        ? CommentedOnYourPostNotification(
                                            uid: notificationsSnapshot
                                                .data.docs[i]['userUid'],
                                            title: notificationsSnapshot
                                                .data.docs[i]['title'],
                                            notificationId:
                                                notificationsSnapshot.data
                                                    .docs[i]['notificationId'],
                                            notifcationDate:
                                                notificationsSnapshot
                                                    .data.docs[i]['sentAt'],
                                          )
                                        : notificationsSnapshot.data.docs[i]
                                                    ['type'] ==
                                                'repost'
                                            ? RepostedYourPostNotification(
                                                uid: notificationsSnapshot
                                                    .data.docs[i]['userUid'],
                                                title: notificationsSnapshot
                                                    .data.docs[i]['title'],
                                                notificationId:
                                                    notificationsSnapshot
                                                            .data.docs[i]
                                                        ['notificationId'],
                                                notifcationDate:
                                                    notificationsSnapshot
                                                        .data.docs[i]['sentAt'],
                                              )
                                            : notificationsSnapshot.data.docs[i]
                                                        ['type'] ==
                                                    'replyToComment'
                                                ? RepliedOnYourCommentNotification(
                                                    uid: notificationsSnapshot
                                                        .data
                                                        .docs[i]['userUid'],
                                                    title: notificationsSnapshot
                                                        .data.docs[i]['title'],
                                                    notificationId:
                                                        notificationsSnapshot
                                                                .data.docs[i]
                                                            ['notificationId'],
                                                    notifcationDate:
                                                        notificationsSnapshot
                                                            .data
                                                            .docs[i]['sentAt'],
                                                  )
                                                : notificationsSnapshot.data
                                                            .docs[i]['type'] ==
                                                        'likereplyToComment'
                                                    ? LikedReplyToCommentNotification(
                                                        uid:
                                                            notificationsSnapshot
                                                                    .data
                                                                    .docs[i]
                                                                ['userUid'],
                                                        title:
                                                            notificationsSnapshot
                                                                    .data
                                                                    .docs[i]
                                                                ['title'],
                                                        notificationId:
                                                            notificationsSnapshot
                                                                    .data
                                                                    .docs[i][
                                                                'notificationId'],
                                                        notifcationDate:
                                                            notificationsSnapshot
                                                                    .data
                                                                    .docs[i]
                                                                ['sentAt'],
                                                      )
                                                    : notificationsSnapshot.data
                                                                    .docs[i]
                                                                ['type'] ==
                                                            'dislikereplyToComment'
                                                        ? DisLikedReplyToCommentNotification(
                                                            uid:
                                                                notificationsSnapshot
                                                                        .data
                                                                        .docs[i]
                                                                    ['userUid'],
                                                            title:
                                                                notificationsSnapshot
                                                                        .data
                                                                        .docs[i]
                                                                    ['title'],
                                                            notificationId:
                                                                notificationsSnapshot
                                                                        .data
                                                                        .docs[i]
                                                                    [
                                                                    'notificationId'],
                                                            notifcationDate:
                                                                notificationsSnapshot
                                                                        .data
                                                                        .docs[i]
                                                                    ['sentAt'],
                                                          )
                                                        : const SizedBox();
                          },
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: ref
                        .read(notificationsControllerProvider)
                        .notificationsStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot notificationsSnapshot) {
                      if (notificationsSnapshot.data == null) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: Get.height * 0.8,
                        width: Get.width,
                        child: ListView.builder(
                          itemCount: notificationsSnapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int i) {
                            return notificationsSnapshot.data.docs[i]['type'] ==
                                    'friendRequest'
                                ? Column(
                                    children: [
                                      FriendRequestNotification(
                                        uid: notificationsSnapshot.data.docs[i]
                                            ['userUid'],
                                        title: notificationsSnapshot
                                            .data.docs[i]['title'],
                                        notificationId: notificationsSnapshot
                                            .data.docs[i]['notificationId'],
                                        notifcationDate: notificationsSnapshot
                                            .data.docs[i]['sentAt'],
                                      ),
                                      Divider(
                                        color: AppColors.lightGrey,
                                        thickness: 0.5,
                                      ),
                                    ],
                                  )
                                : notificationsSnapshot.data.docs[i]['type'] ==
                                        'acceptedRequest'
                                    ? Column(
                                        children: [
                                          AcceptedRequestNotification(
                                            uid: notificationsSnapshot
                                                .data.docs[i]['userUid'],
                                            title: notificationsSnapshot
                                                .data.docs[i]['title'],
                                            notificationId:
                                                notificationsSnapshot.data
                                                    .docs[i]['notificationId'],
                                            notifcationDate:
                                                notificationsSnapshot
                                                    .data.docs[i]['sentAt'],
                                          ),
                                          Divider(
                                            color: AppColors.lightGrey,
                                            thickness: 0.5,
                                          ),
                                        ],
                                      )
                                    : notificationsSnapshot.data.docs[i]
                                                ['type'] ==
                                            'startedFollowing'
                                        ? Column(
                                            children: [
                                              StartedFollowingNotification(
                                                uid: notificationsSnapshot
                                                    .data.docs[i]['userUid'],
                                                title: notificationsSnapshot
                                                    .data.docs[i]['title'],
                                                notificationId:
                                                    notificationsSnapshot
                                                            .data.docs[i]
                                                        ['notificationId'],
                                                notifcationDate:
                                                    notificationsSnapshot
                                                        .data.docs[i]['sentAt'],
                                              ),
                                              Divider(
                                                color: AppColors.lightGrey,
                                                thickness: 0.5,
                                              ),
                                            ],
                                          )
                                        : const SizedBox();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
