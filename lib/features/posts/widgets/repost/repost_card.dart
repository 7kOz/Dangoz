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
import 'package:dangoz/features/posts/widgets/repost/repost_header.dart';
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

class RepostCard extends ConsumerStatefulWidget {
  String repostId;
  String postId;
  String posterId;
  String reposterId;
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
  RepostCard({
    Key? key,
    required this.repostId,
    required this.postId,
    required this.posterId,
    required this.reposterId,
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
  }) : super(key: key);

  @override
  ConsumerState<RepostCard> createState() => _RepostCardState();
}

class _RepostCardState extends ConsumerState<RepostCard> {
  bool showCommentSection = false;
  TextEditingController comment = TextEditingController();
  File? image;
  GiphyGif? gif;
  late Future repostData;

  @override
  void initState() {
    super.initState();
    repostData = getRepostData();
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

  Future getRepostData() async {
    return await FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.repostId)
        .get();
  }

  void likeAPost() {
    ref.read(postControllerProvider).likeAPost(widget.postId, widget.reposterId,
        FirebaseAuth.instance.currentUser!.uid);
  }

  void unLikeAPost() {
    ref.read(postControllerProvider).unLikeAPost(widget.postId,
        widget.reposterId, FirebaseAuth.instance.currentUser!.uid);
  }

  void disLikeAPost() {
    ref.read(postControllerProvider).disLikeAPost(widget.postId,
        widget.reposterId, FirebaseAuth.instance.currentUser!.uid);
  }

  void unDisLikeAPost() {
    ref.read(postControllerProvider).unDisLikeAPost(widget.postId,
        widget.reposterId, FirebaseAuth.instance.currentUser!.uid);
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
          widget.reposterId,
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
              onTap: () {
                Get.to(
                  () => PostDetailsScreen(
                    postId: widget.postId,
                    posterId: widget.reposterId,
                  ),
                );
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RepostHeader(
                        postId: widget.postId,
                        posterId: widget.reposterId,
                        sponsered: widget.sponsered,
                        timePosted: widget.timePosted,
                        imageUrl: widget.imageUrl,
                        videoUrl: widget.videoUrl,
                        postCategory: postCategory()),
                    const SizedBox(height: 20),
                    FutureBuilder(
                        future: repostData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const SizedBox();
                          }
                          var repost = snapshot.data;
                          if (repost['deleted'] == true) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: Get.width * 0.0325,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Icon(
                                    CupertinoIcons.repeat,
                                    color: AppColors.navy,
                                    size: Get.width * 0.05,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.navy),
                                  child: Center(
                                    child: Text(
                                      'Post Deleted',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        letterSpacing: 1,
                                        fontSize: Get.width * 0.03,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return postContent(
                            widget.post,
                            repost['reposterId'] == ''
                                ? repost['posterId']
                                : repost['reposterId'],
                            repost['isGeneralPost'],
                            repost['isNewsPost'],
                            repost['isIdeasPost'],
                            repost['isSignalPost'],
                            repost['isMemePost'],
                            repost['isSponsered'],
                            repost['timePosted'],
                            repost['post'],
                            repost['postId'],
                            repost['imageUrl'],
                            repost['gifUrl'],
                            repost['videoUrl'],
                          );
                        }),
                    const SizedBox(height: 30),
                    postFooter(),
                    showCommentSection == true
                        ? const SizedBox(height: 30)
                        : const SizedBox(),
                    showCommentSection == true
                        ? commentSection()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.0),
        Divider(color: AppColors.navy),
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

  Widget postContent(
    String post,
    String reposterId,
    bool general,
    bool news,
    bool idea,
    bool signal,
    bool meme,
    bool isSponsered,
    int timePosted,
    String repost,
    String repostId,
    String imageUrl,
    String gifUrl,
    String videoUrl,
  ) {
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
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Icon(
            CupertinoIcons.repeat,
            color: AppColors.navy,
            size: Get.width * 0.05,
          ),
        ),
        SizedBox(height: 20),
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(reposterId)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const SizedBox();
              }
              var reposter = snapshot.data;
              return InkWell(
                onTap: () {
                  Get.to(
                    () => PostDetailsScreen(
                      postId: repostId,
                      posterId: reposter['uid'],
                    ),
                  );
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.navy.withOpacity(1),
                      border: Border.all(
                        color: AppColors.navy,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          rePostHeader(
                            widget.repostId,
                            reposterId,
                            general,
                            news,
                            idea,
                            signal,
                            meme,
                            isSponsered,
                            timePosted,
                          ),
                          const SizedBox(height: 20),
                          repostContent(repost, imageUrl, gifUrl, videoUrl),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget postFooter() {
    return StreamBuilder(
        stream: ref.read(postControllerProvider).postDataById(widget.postId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          PostModel postData = snapshot.data;
          return Container(
            height: Get.height * 0.02,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StreamBuilder(
                          stream: ref
                              .read(postControllerProvider)
                              .postLikesInteractionsStream(widget.postId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
                            }
                            bool isLiked = false;
                            int snapshotLength = snapshot.data.docs.length;
                            for (int i = 0; i < snapshotLength; i++) {
                              FirebaseAuth.instance.currentUser!.uid ==
                                  snapshot.data.docs[i];
                              isLiked = true;
                            }
                            return InkWell(
                              onTap: isLiked == true ? unLikeAPost : likeAPost,
                              child: Icon(
                                isLiked == true
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: isLiked == true
                                    ? AppColors.green
                                    : AppColors.navy,
                                size: Get.width * 0.05,
                              ),
                            );
                          }),
                      const SizedBox(width: 5),
                      Text(
                        NumberFormat.compact().format(postData.likes),
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showCommentSection = !showCommentSection;
                          });
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: Icon(
                          CupertinoIcons.chat_bubble,
                          color: AppColors.navy,
                          size: Get.width * 0.05,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        NumberFormat.compact().format(postData.comments),
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StreamBuilder(
                          stream: ref
                              .read(postControllerProvider)
                              .postDisLikesInteractionsStream(widget.postId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
                            }
                            bool isDisLiked = false;
                            int snapshotLength = snapshot.data.docs.length;
                            for (int i = 0; i < snapshotLength; i++) {
                              FirebaseAuth.instance.currentUser!.uid ==
                                  snapshot.data.docs[i];
                              isDisLiked = true;
                            }
                            return InkWell(
                              onTap: isDisLiked == true
                                  ? unDisLikeAPost
                                  : disLikeAPost,
                              child: Icon(
                                isDisLiked == true
                                    ? CupertinoIcons.hand_thumbsdown_fill
                                    : CupertinoIcons.hand_thumbsdown,
                                color: isDisLiked == true
                                    ? AppColors.red
                                    : AppColors.navy,
                                size: Get.width * 0.05,
                              ),
                            );
                          }),
                      const SizedBox(width: 5),
                      Text(
                        NumberFormat.compact().format(postData.dislikes),
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => RepostScreen(
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
                              isRepost: widget.isRepost,
                              reposterId: widget.reposterId,
                            ),
                          );
                        },
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        child: Icon(
                          CupertinoIcons.repeat,
                          color: AppColors.navy,
                          size: Get.width * 0.05,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        NumberFormat.compact().format(postData.reposts),
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: Get.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget commentSection() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Container(
              height: Get.height * 0.125,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
              ),
              child: StreamBuilder<UserModel>(
                stream: ref
                    .read(postControllerProvider)
                    .userDataById(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.data!.profileImage == ''
                            ? CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.white,
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: AppColors.navy,
                                  size: Get.width * 0.05,
                                )),
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.white,
                                backgroundImage: NetworkImage(
                                  snapshot.data!.profileImage as String,
                                ),
                              ),
                        SizedBox(width: 5),
                        Container(
                          width: Get.width * 0.7,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextField(
                            controller: comment,
                            cursorColor: AppColors.navy,
                            maxLength: 200,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Comment',
                              hintStyle: TextStyle(
                                color: AppColors.lightGrey,
                                fontSize: Get.width * 0.035,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    image != null
                        ? Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(image!.path),
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.2,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(width: 10),
                    gif != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: Get.width * 0.4,
                              child: GiphyImageView(
                                width: Get.width * 0.4,
                                height: Get.height * 0.2,
                                fit: BoxFit.fill,
                                gif: gif!,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: Get.height * 0.055,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: selectGIF,
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Icon(
                        Icons.gif,
                        color: AppColors.navy,
                        size: Get.width * 0.07,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: selectImage,
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.navy,
                        size: Get.width * 0.07,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (comment.text != '' ||
                            image != null ||
                            gif != null) {
                          commentOnaPost();
                          setState(() {
                            comment.text = '';
                            comment.clear();
                            gif = null;
                            image = null;
                            showCommentSection = false;
                          });
                          Get.snackbar(
                            '🥳',
                            'Comment Posted',
                            backgroundColor: AppColors.green,
                            colorText: AppColors.white,
                          );
                        } else {
                          Get.snackbar(
                            'Oops',
                            'Ghosts Can\'t View This',
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                          );
                        }
                      },
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Container(
                        height: Get.height * 0.04,
                        width: Get.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.navy,
                        ),
                        child: Center(
                          child: Text(
                            'Comment',
                            style: TextStyle(
                              color: AppColors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rePostHeader(
    String repostId,
    String reposterId,
    bool general,
    bool news,
    bool idea,
    bool signal,
    bool meme,
    bool isSponsered,
    int timePosted,
  ) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(reposterId)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const SizedBox();
          }
          var reposter = snapshot.data;

          return Container(
            height: Get.height * 0.1,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    reposter['profileImage'] == ''
                        ? InkWell(
                            onTap: () {
                              Get.to(() => ProfilesScreen(
                                    profileId: reposter['uid'],
                                  ));
                            },
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: CircleAvatar(
                              radius: Get.height * 0.025,
                              backgroundColor: AppColors.white,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.lightGrey,
                                  size: Get.width * 0.04,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Get.to(() => ProfilesScreen(
                                    profileId: reposter['uid'],
                                  ));
                            },
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: CircleAvatar(
                              radius: Get.height * 0.025,
                              backgroundImage: NetworkImage(
                                reposter['profileImage'] as String,
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
                              reposter['name'],
                              style: TextStyle(
                                color: AppColors.white,
                                letterSpacing: 1,
                                fontSize: Get.width * 0.0275,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            reposter['isPro'] == true
                                ? Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: AppColors.green,
                                    size: Get.width * 0.035,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: Get.height * 0.016,
                          child: Center(
                              child: Text(
                            '@${reposter['userName']}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: Get.width * 0.0275,
                            ),
                          )),
                        ),
                        const SizedBox(height: 2),
                        isSponsered == true
                            ? Container(
                                height: Get.height * 0.02,
                                color: AppColors.navy,
                                child: Center(
                                    child: Text(
                                  'Sponsered',
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: Get.width * 0.0275,
                                  ),
                                )),
                              )
                            : const SizedBox(),
                        isSponsered == true
                            ? const SizedBox(height: 2)
                            : const SizedBox(),
                        Text(
                          timeago.format(
                              DateTime.fromMillisecondsSinceEpoch(timePosted),
                              locale: 'en_short'),
                          style: TextStyle(
                            color: AppColors.lightGrey,
                            letterSpacing: 1,
                            fontSize: Get.width * 0.025,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child: repostCategory(general, news, idea, signal, meme),
                ),
              ],
            ),
          );
        });
  }

  Widget repostCategory(
      bool general, bool news, bool idea, bool signal, bool meme) {
    return general
        ? Text(
            'General',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              fontSize: Get.width * 0.025,
            ),
          )
        : news
            ? Text(
                '${Emoji.byChar(Emojis.newspaper)}',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  fontSize: Get.width * 0.04,
                ),
              )
            : idea
                ? Text(
                    '${Emoji.byChar(Emojis.lightBulb)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.04,
                    ),
                  )
                : signal
                    ? Text(
                        '${Emoji.byChar(Emojis.chartIncreasing)}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          fontSize: Get.width * 0.04,
                        ),
                      )
                    : meme
                        ? Text(
                            '${Emoji.byChar(Emojis.clownFace)}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              fontSize: Get.width * 0.04,
                            ),
                          )
                        : Container();
  }

  Widget repostContent(
      String repost, String imageUrl, String gifUrl, String videoUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          repost,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: AppColors.white,
            fontSize: Get.width * 0.0325,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: gifUrl == '' && imageUrl == '' && videoUrl == ''
                ? AppColors.navy
                : AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageUrl == ''
                    ? const SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {
                            showImageViewer(
                              context,
                              NetworkImage(imageUrl),
                              onViewerDismissed: () {},
                              swipeDismissible: true,
                              doubleTapZoomable: true,
                            );
                          },
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: imageUrl,
                            height: gifUrl == '' && videoUrl == ''
                                ? Get.height * 0.1
                                : gifUrl == '' || videoUrl == ''
                                    ? Get.height * 0.1
                                    : Get.height * 0.1,
                            width: gifUrl == '' && videoUrl == ''
                                ? Get.width * 0.4
                                : gifUrl == '' || videoUrl == ''
                                    ? Get.width * 0.3
                                    : Get.width * 0.225,
                          ),
                        ),
                      ),
                const SizedBox(width: 10),
                gifUrl == ''
                    ? const SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {
                            showImageViewer(
                              context,
                              NetworkImage(gifUrl),
                              onViewerDismissed: () {},
                              swipeDismissible: true,
                              doubleTapZoomable: true,
                            );
                          },
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: gifUrl,
                            height: imageUrl == '' && videoUrl == ''
                                ? Get.height * 0.1
                                : imageUrl == '' || videoUrl == ''
                                    ? Get.height * 0.1
                                    : Get.height * 0.1,
                            width: imageUrl == '' && videoUrl == ''
                                ? Get.width * 0.4
                                : imageUrl == '' || videoUrl == ''
                                    ? Get.width * 0.3
                                    : Get.width * 0.225,
                          ),
                        ),
                      ),
                const SizedBox(width: 10),
                videoUrl == ''
                    ? const SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            height: gifUrl == '' && imageUrl == ''
                                ? Get.height * 0.1
                                : gifUrl == '' || imageUrl == ''
                                    ? Get.height * 0.1
                                    : Get.height * 0.1,
                            width: gifUrl == '' && imageUrl == ''
                                ? Get.width * 0.6
                                : gifUrl == '' || imageUrl == ''
                                    ? Get.width * 0.3
                                    : Get.width * 0.225,
                            child: InkWell(
                                onDoubleTap: () {
                                  Get.to(
                                      FullPostVideoPlayer(videoUrl: videoUrl));
                                },
                                splashColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                child: PostVideoPlayer(videoUrl: videoUrl))),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
