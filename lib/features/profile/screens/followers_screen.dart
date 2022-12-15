import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/profile/controller/profile_controller.dart';
import 'package:dangoz/features/profile/widgets/follower_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FollowersScreen extends ConsumerWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: ref.read(profileControllerProvider).followersStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const SizedBox();
          }
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              centerTitle: true,
              leading: Theme(
                data: ThemeData(highlightColor: Colors.transparent),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  splashColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.chevron_back,
                    color: AppColors.navy,
                    size: Get.width * 0.06,
                  ),
                ),
              ),
              title: Text(
                'Followers',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
            body: SizedBox(
              height: Get.height * 0.8,
              width: Get.width,
              child: snapshot.data.docs.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Have No Followers',
                          style: TextStyle(
                              color: AppColors.navy,
                              fontSize: Get.width * 0.035,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                        LottieBuilder.asset(
                          'assets/animations/ghost.json',
                          height: Get.height * 0.5,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var followerUid = snapshot.data.docs[index]['uid'];
                        return Column(
                          children: [
                            FollowerContainer(followerId: followerUid),
                            Divider(
                              color: AppColors.lightGrey,
                              thickness: 0.5,
                            ),
                          ],
                        );
                      },
                    ),
            ),
          );
        });
  }
}
