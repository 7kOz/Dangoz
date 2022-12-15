import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/posts/widgets/post_card.dart';
import 'package:dangoz/features/posts/widgets/post_card_repost_view.dart';
import 'package:dangoz/features/posts/widgets/upload_post_container.dart';
import 'package:dangoz/features/posts/widgets/upload_repost_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RepostScreen extends ConsumerStatefulWidget {
  String postId;
  String posterId;
  String name;
  String userName;
  String profileUrl;
  String post;
  String gifUrl;
  String imageUrl;
  String videoUrl;
  DateTime timePosted;
  bool verified;
  bool sponsered;
  bool general;
  bool news;
  bool idea;
  bool signal;
  bool meme;
  bool isRepost;
  String reposterId;
  RepostScreen({
    super.key,
    required this.postId,
    required this.posterId,
    required this.name,
    required this.userName,
    required this.profileUrl,
    required this.post,
    required this.gifUrl,
    required this.imageUrl,
    required this.videoUrl,
    required this.timePosted,
    required this.verified,
    required this.sponsered,
    required this.general,
    required this.news,
    required this.idea,
    required this.signal,
    required this.meme,
    required this.isRepost,
    required this.reposterId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepostScreenState();
}

class _RepostScreenState extends ConsumerState<RepostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        leading: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            radius: 0,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Icon(
              Icons.close,
              color: AppColors.red,
              size: Get.width * 0.05,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.white,
              child: StreamBuilder(
                stream: ref
                    .read(postControllerProvider)
                    .userDataById(FirebaseAuth.instance.currentUser!.uid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      UploadRepostContainer(
                        postId: widget.postId,
                        posterId: widget.posterId,
                      ),
                      SizedBox(height: Get.height * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.025,
                            child: VerticalDivider(
                              color: AppColors.navy,
                              width: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: Get.height * 0.025,
                            child: VerticalDivider(
                              color: AppColors.navy,
                              width: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: Get.height * 0.025,
                            child: VerticalDivider(
                              color: AppColors.navy,
                              width: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PostCardRepostView(
                            postId: widget.postId,
                            posterId: widget.posterId,
                            name: widget.name,
                            userName: widget.userName,
                            profileUrl: widget.profileUrl,
                            post: widget.post,
                            gifUrl: widget.gifUrl,
                            imageUrl: widget.imageUrl,
                            videoUrl: widget.videoUrl,
                            timePosted: widget.timePosted,
                            verified: widget.verified,
                            sponsered: widget.sponsered,
                            general: widget.general,
                            news: widget.news,
                            idea: widget.idea,
                            signal: widget.signal,
                            meme: widget.meme,
                            reposterId: widget.reposterId,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
