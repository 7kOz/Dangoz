import 'dart:convert';

import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/profiles/controller/profiles_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class FollowUnfollowWidget extends ConsumerStatefulWidget {
  String baseId;
  bool privateUser;
  FollowUnfollowWidget(
      {super.key, required this.baseId, required this.privateUser});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FollowUnfollowWidgetState();
}

class _FollowUnfollowWidgetState extends ConsumerState<FollowUnfollowWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void followUser() {
    ref.read(profilesControllerProvider).followUser(widget.baseId);
  }

  void followPrivateUser() {
    ref.read(profilesControllerProvider).followPrivateUser(widget.baseId);
  }

  void cancelFriendRequest(String notificationId) {
    ref
        .read(profilesControllerProvider)
        .cancelFriendRequest(widget.baseId, notificationId);
  }

  void unFollowUser() {
    ref.read(profilesControllerProvider).unFollowUser(widget.baseId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref
            .read(profilesControllerProvider)
            .notificationsStream(widget.baseId),
        builder: (BuildContext context, AsyncSnapshot notificationSnapshot) {
          if (notificationSnapshot.data == null) {
            return const SizedBox();
          }
          String notifId = '';
          bool notificationSent = false;
          int notificationsSnapshotLength =
              notificationSnapshot.data.docs.length;
          var notificationsSnapshot = notificationSnapshot.data.docs;
          for (int i = 0; i < notificationsSnapshotLength; i++) {
            if (notificationsSnapshot[i]['type'] == 'friendRequest' &&
                FirebaseAuth.instance.currentUser!.uid ==
                    notificationsSnapshot[i]['userUid']) {
              notificationSent = true;
              notifId = notificationSnapshot.data.docs[i]['notificationId'];
            }
          }
          return StreamBuilder(
              stream: ref.read(profilesControllerProvider).followingStream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox();
                }
                bool following = false;

                int snapshotLength = snapshot.data.docs.length;
                for (int i = 0; i < snapshotLength; i++) {
                  if (widget.baseId == snapshot.data.docs[i]['uid']) {
                    following = true;
                  }
                }
                return StreamBuilder(
                    stream:
                        ref.read(profilesControllerProvider).followersStream(),
                    builder: (BuildContext context, AsyncSnapshot fSnapshot) {
                      if (fSnapshot.data == null) {
                        return const SizedBox();
                      }
                      bool followingBack = false;

                      int fSnapshotLength = fSnapshot.data.docs.length;
                      for (int i = 0; i < fSnapshotLength; i++) {
                        if (widget.baseId == fSnapshot.data.docs[i]['uid']) {
                          followingBack = true;
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: notificationSent == true
                              ? () => cancelFriendRequest(notifId)
                              : following == true
                                  ? unFollowUser
                                  : widget.privateUser != true
                                      ? followUser
                                      : followPrivateUser,
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: notificationSent == true
                                  ? AppColors.lightGrey
                                  : following == true
                                      ? AppColors.red
                                      : AppColors.green,
                            ),
                            child: Center(
                              child: Text(
                                notificationSent == true
                                    ? 'Cancel Request'
                                    : following == true
                                        ? 'Unfollow'
                                        : followingBack == true
                                            ? 'Follow Back'
                                            : 'Follow',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
