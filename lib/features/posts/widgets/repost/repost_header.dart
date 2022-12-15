import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/profile/controller/profile_controller.dart';
import 'package:dangoz/features/profiles/controller/profiles_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepostHeader extends ConsumerWidget {
  String postId;
  String posterId;
  bool sponsered;
  DateTime timePosted;
  Widget postCategory;
  String imageUrl;
  String videoUrl;
  RepostHeader({
    super.key,
    required this.postId,
    required this.posterId,
    required this.sponsered,
    required this.timePosted,
    required this.postCategory,
    required this.imageUrl,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: Get.height * 0.08,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future:
                  ref.read(postControllerProvider).userDataByIdFuture(posterId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox();
                }
                var user = snapshot.data.docs[0];
                return Row(
                  children: [
                    user['profileImage'] == ''
                        ? InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: CircleAvatar(
                              radius: Get.height * 0.03,
                              backgroundColor: AppColors.navy,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.lightGrey,
                                  size: Get.width * 0.05,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: CircleAvatar(
                              radius: Get.height * 0.03,
                              backgroundImage: NetworkImage(
                                user['profileImage'],
                              ),
                            ),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              user['name'],
                              style: TextStyle(
                                color: AppColors.navy,
                                letterSpacing: 1,
                                fontSize: Get.width * 0.0325,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            user['isVerified'] == true
                                ? Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: AppColors.green,
                                    size: Get.width * 0.04,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: Get.height * 0.02,
                          color: AppColors.white,
                          child: Center(
                              child: Text(
                            '@${user['userName']}',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: Get.width * 0.03,
                            ),
                          )),
                        ),
                        const SizedBox(height: 5),
                        sponsered == true
                            ? Container(
                                height: Get.height * 0.02,
                                width: Get.width * 0.16,
                                color: AppColors.white,
                                child: Center(
                                    child: Text(
                                  'Sponsered',
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: Get.width * 0.03,
                                  ),
                                )),
                              )
                            : const SizedBox(),
                        sponsered == true
                            ? const SizedBox(height: 5)
                            : const SizedBox(),
                        Text(
                          timeago.format(timePosted, locale: 'en_short'),
                          style: TextStyle(
                            color: AppColors.lightGrey,
                            letterSpacing: 1,
                            fontSize: Get.width * 0.0275,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                posterId == FirebaseAuth.instance.currentUser!.uid
                    ? InkWell(
                        onTap: () {
                          ref
                              .read(postControllerProvider)
                              .deletePost(postId, posterId, imageUrl, videoUrl);
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: Icon(
                          CupertinoIcons.delete_left_fill,
                          color: AppColors.red,
                          size: Get.width * 0.05,
                        ),
                      )
                    : const SizedBox(),
                postCategory,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
