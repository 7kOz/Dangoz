import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/utils.dart';
import 'package:dangoz/features/chat/widgets/chat_video_player.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/posts/screens/post_details_screen.dart';
import 'package:dangoz/features/posts/screens/repost_screen.dart';
import 'package:dangoz/features/posts/widgets/full_video_player_screen.dart';
import 'package:dangoz/features/posts/widgets/post_video_player.dart';
import 'package:dangoz/features/profile/controller/profile_controller.dart';
import 'package:dangoz/features/profiles/screens/profiles_screen.dart';
import 'package:dangoz/models/post_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_image_viewer/easy_image_viewer.dart';

class PostCardRepostView extends ConsumerStatefulWidget {
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
  String reposterId;
  PostCardRepostView({
    Key? key,
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
    required this.reposterId,
  }) : super(key: key);

  @override
  ConsumerState<PostCardRepostView> createState() => _PostCardRepostViewState();
}

class _PostCardRepostViewState extends ConsumerState<PostCardRepostView> {
  bool showCommentSection = false;
  TextEditingController comment = TextEditingController();
  File? image;
  GiphyGif? gif;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      comment.text = '';
      comment.clear();
      image = null;
      gif = null;
    });
  }

  void likeAPost() {
    ref.read(postControllerProvider).likeAPost(
        widget.postId, widget.posterId, FirebaseAuth.instance.currentUser!.uid);
  }

  void unLikeAPost() {
    ref.read(postControllerProvider).unLikeAPost(
        widget.postId, widget.posterId, FirebaseAuth.instance.currentUser!.uid);
  }

  void disLikeAPost() {
    ref.read(postControllerProvider).disLikeAPost(
        widget.postId, widget.posterId, FirebaseAuth.instance.currentUser!.uid);
  }

  void unDisLikeAPost() {
    ref.read(postControllerProvider).unDisLikeAPost(
        widget.postId, widget.posterId, FirebaseAuth.instance.currentUser!.uid);
  }

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void selectGIF() async {
    gif = await pickGIF(context);
    setState(() {});
  }

  void commentOnaPost() {
    ref.read(postControllerProvider).commentOnAPost(
          widget.postId,
          widget.posterId,
          FirebaseAuth.instance.currentUser!.uid,
          comment.text,
          gif == null ? '' : gif!.url,
          image,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    postHeader(widget.posterId),
                    const SizedBox(height: 20),
                    postContent(widget.post),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget postCategory() {
    return widget.general
        ? Text(
            'General',
            style: TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              fontSize: Get.width * 0.0275,
            ),
          )
        : widget.news
            ? Text(
                '${Emoji.byChar(Emojis.newspaper)}',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  fontSize: Get.width * 0.05,
                ),
              )
            : widget.idea
                ? Text(
                    '${Emoji.byChar(Emojis.lightBulb)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.05,
                    ),
                  )
                : widget.signal
                    ? Text(
                        '${Emoji.byChar(Emojis.chartIncreasing)}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          fontSize: Get.width * 0.05,
                        ),
                      )
                    : widget.meme
                        ? Text(
                            '${Emoji.byChar(Emojis.clownFace)}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              fontSize: Get.width * 0.05,
                            ),
                          )
                        : Container();
  }

  Widget postHeader(String posterId) {
    return StreamBuilder<UserModel>(
        stream: ref.read(profileControllerProvider).userDataById(
            widget.reposterId == '' ? widget.posterId : widget.reposterId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const SizedBox();
          }

          UserModel reposterData = snapshot.data;
          return Container(
            height: Get.height * 0.1,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    reposterData.profileImage == ''
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
                                reposterData.profileImage as String,
                              ),
                            ),
                          ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              reposterData.name,
                              style: TextStyle(
                                color: AppColors.navy,
                                letterSpacing: 1,
                                fontSize: Get.width * 0.0325,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            reposterData.isVerified == true
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
                            '@${reposterData.userName}',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: Get.width * 0.03,
                            ),
                          )),
                        ),
                        const SizedBox(height: 5),
                        widget.sponsered == true
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
                        widget.sponsered == true
                            ? const SizedBox(height: 5)
                            : const SizedBox(),
                        Text(
                          timeago.format(widget.timePosted),
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
                ),
                postCategory(),
              ],
            ),
          );
        });
  }

  Widget postContent(String post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: Get.width * 0.0325,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: Get.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.imageUrl == ''
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          showImageViewer(
                            context,
                            NetworkImage(widget.imageUrl),
                            onViewerDismissed: () {},
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                          );
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: widget.imageUrl,
                          height: widget.gifUrl == '' && widget.videoUrl == ''
                              ? Get.height * 0.2
                              : widget.gifUrl == '' || widget.videoUrl == ''
                                  ? Get.height * 0.2
                                  : Get.height * 0.2,
                          width: widget.gifUrl == '' && widget.videoUrl == ''
                              ? Get.width * 0.4
                              : widget.gifUrl == '' || widget.videoUrl == ''
                                  ? Get.width * 0.45
                                  : Get.width * 0.275,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              widget.gifUrl == ''
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          showImageViewer(
                            context,
                            NetworkImage(widget.gifUrl),
                            onViewerDismissed: () {},
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                          );
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: widget.gifUrl,
                          height: widget.imageUrl == '' && widget.videoUrl == ''
                              ? Get.height * 0.2
                              : widget.imageUrl == '' || widget.videoUrl == ''
                                  ? Get.height * 0.2
                                  : Get.height * 0.2,
                          width: widget.imageUrl == '' && widget.videoUrl == ''
                              ? Get.width * 0.5
                              : widget.imageUrl == '' || widget.videoUrl == ''
                                  ? Get.width * 0.4
                                  : Get.width * 0.275,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              widget.videoUrl == ''
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                          height: widget.gifUrl == '' && widget.imageUrl == ''
                              ? Get.height * 0.2
                              : widget.gifUrl == '' || widget.imageUrl == ''
                                  ? Get.height * 0.2
                                  : Get.height * 0.2,
                          width: widget.gifUrl == '' && widget.imageUrl == ''
                              ? Get.width * 0.65
                              : widget.gifUrl == '' || widget.imageUrl == ''
                                  ? Get.width * 0.4
                                  : Get.width * 0.275,
                          child: InkWell(
                              onDoubleTap: () {
                                Get.to(FullPostVideoPlayer(
                                    videoUrl: widget.videoUrl));
                              },
                              splashColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              child:
                                  PostVideoPlayer(videoUrl: widget.videoUrl))),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
