import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/profile/controller/profile_controller.dart';
import 'package:dangoz/features/profiles/screens/profiles_screen.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FollowerContainer extends ConsumerWidget {
  String followerId;
  FollowerContainer({super.key, required this.followerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<UserModel>(
        stream: ref.read(profileControllerProvider).userDataById(followerId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const SizedBox();
          }
          UserModel follower = snapshot.data;
          return Container(
            height: Get.height * 0.075,
            width: Get.width,
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                follower.profileImage == ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                () => ProfilesScreen(profileId: follower.uid));
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
                    : InkWell(
                        onTap: () {
                          Get.to(() => ProfilesScreen(profileId: follower.uid));
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              follower.profileImage as String,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.47,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                            child: Text(
                              follower.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.navy,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 4),
                      child: Text(
                        '@${follower.userName}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(profileControllerProvider)
                          .removeFollower(follower.uid);
                    },
                    child: Container(
                        width: Get.width * 0.25,
                        height: Get.height * 0.04,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Remove',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: Get.width * 0.03,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          );
        });
  }
}
