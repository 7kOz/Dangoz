import 'package:dangoz/base/app_colors.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class PostCard extends StatefulWidget {
  String postId;
  String image;
  String name;
  String time;
  bool verified;
  bool sponsered;
  bool general;
  bool news;
  bool idea;
  bool signal;
  bool meme;
  bool onlyText;
  bool hasImage;
  bool hasVideo;
  String videoUrl;
  bool isLiked;
  bool isDisliked;
  int likesCount;
  int commentsCount;
  int dislikesCount;
  int repostCount;
  PostCard({
    Key? key,
    required this.postId,
    required this.image,
    required this.name,
    required this.time,
    required this.verified,
    required this.sponsered,
    required this.general,
    required this.news,
    required this.idea,
    required this.signal,
    required this.meme,
    required this.onlyText,
    required this.hasImage,
    required this.hasVideo,
    required this.videoUrl,
    required this.isLiked,
    required this.isDisliked,
    required this.likesCount,
    required this.commentsCount,
    required this.dislikesCount,
    required this.repostCount,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _videoController;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  postHeader(),
                  const SizedBox(height: 20),
                  postContent(),
                  const SizedBox(height: 30),
                  Container(
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
                              widget.isLiked
                                  ? Icon(
                                      CupertinoIcons.heart_fill,
                                      color: AppColors.green,
                                      size: Get.width * 0.05,
                                    )
                                  : Icon(
                                      CupertinoIcons.heart,
                                      color: AppColors.navy,
                                      size: Get.width * 0.05,
                                    ),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.likesCount),
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
                              Icon(
                                CupertinoIcons.chat_bubble,
                                color: AppColors.navy,
                                size: Get.width * 0.05,
                              ),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.commentsCount),
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
                              widget.isDisliked
                                  ? Icon(
                                      CupertinoIcons.hand_thumbsdown_fill,
                                      color: AppColors.red,
                                      size: Get.width * 0.05,
                                    )
                                  : Icon(
                                      CupertinoIcons.hand_thumbsdown,
                                      color: AppColors.navy,
                                      size: Get.width * 0.05,
                                    ),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.dislikesCount),
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
                              Icon(
                                CupertinoIcons.repeat,
                                color: AppColors.navy,
                                size: Get.width * 0.05,
                              ),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.repostCount),
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
                  )
                ],
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

  Widget postHeader() {
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: Get.height * 0.03,
                backgroundImage: AssetImage(
                  widget.image,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: AppColors.navy,
                          letterSpacing: 1,
                          fontSize: Get.width * 0.0325,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      widget.verified == true
                          ? Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: AppColors.green,
                              size: Get.width * 0.04,
                            )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(width: 10),
                  Container(
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
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.time,
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
  }

  Widget postContent() {
    return widget.onlyText
        ? Container(
            child: Text(
              'A paragraph is a group of sentences that fleshes out a single idea. In order for a paragraph to be effective, it must begin with a topic sentence, have sentences that support the main idea of that paragraph, and maintain a consistent flow.',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: Get.width * 0.0325,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        : widget.hasImage
            ? Column(
                children: [
                  Container(
                    child: Text(
                      'A paragraph is a group of sentences that fleshes out a single idea. In order for a paragraph to be effective, it must begin with a topic sentence, have sentences that support the main idea of that paragraph, and maintain a consistent flow.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: Get.width * 0.0325,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://media-exp1.licdn.com/dms/image/C5603AQGV145NcD4h7w/profile-displayphoto-shrink_200_200/0/1647034727632?e=2147483647&v=beta&t=uQwac2yCY5gyMIjUUkgxli933TGBcnaqgBncU4bcvEQ',
                      width: Get.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              )
            : _videoController.value.isInitialized
                ? Column(
                    children: [
                      Container(
                        child: Text(
                          'A paragraph is a group of sentences that fleshes out a single idea. In order for a paragraph to be effective, it must begin with a topic sentence, have sentences that support the main idea of that paragraph, and maintain a consistent flow.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: Get.width * 0.0325,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  _videoController.value.isPlaying
                                      ? _videoController.pause()
                                      : _videoController.play();
                                });
                              },
                              splashColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              child: VideoPlayer(_videoController)),
                        ),
                      ),
                    ],
                  )
                : Container();
  }
}
