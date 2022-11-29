import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/post_card.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CryptoFeedScreen extends StatefulWidget {
  const CryptoFeedScreen({Key? key}) : super(key: key);

  @override
  State<CryptoFeedScreen> createState() => _CryptoFeedScreenState();
}

class _CryptoFeedScreenState extends State<CryptoFeedScreen> {
  bool general = true;
  bool news = false;
  bool idea = false;
  bool signal = false;
  bool meme = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.025),
          pageTitle(),
          SizedBox(height: Get.height * 0.025),
          categories(),
          SizedBox(height: Get.height * 0.025),
          Container(
            height: Get.height * 0.6,
            child: ListView(
              children: [
                PostCard(
                  postId: '1223',
                  image: 'assets/images/omar.JPG',
                  name: '7koz',
                  time: '5h',
                  verified: false,
                  sponsered: true,
                  general: true,
                  news: false,
                  idea: false,
                  signal: false,
                  meme: false,
                  onlyText: false,
                  hasImage: true,
                  hasVideo: false,
                  videoUrl: '',
                  isLiked: true,
                  isDisliked: false,
                  likesCount: 100,
                  commentsCount: 4,
                  dislikesCount: 2030,
                  repostCount: 500,
                ),
                PostCard(
                  postId: '1222',
                  image: 'assets/images/omar.JPG',
                  name: 'Omar Hakeem',
                  time: '23h',
                  verified: true,
                  sponsered: true,
                  general: false,
                  news: false,
                  idea: false,
                  signal: true,
                  meme: false,
                  onlyText: false,
                  hasImage: false,
                  hasVideo: false,
                  videoUrl:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  isLiked: false,
                  isDisliked: true,
                  likesCount: 100000,
                  commentsCount: 5230,
                  dislikesCount: 2000,
                  repostCount: 320500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pageTitle() {
    return Center(
      child: Text(
        'Crypto Zone',
        style: TextStyle(
            color: AppColors.navy,
            letterSpacing: 1,
            fontSize: Get.width * 0.04,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget categories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: Get.height * 0.05,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  general = true;
                  news = false;
                  idea = false;
                  signal = false;
                  meme = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.05,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: general ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    'General',
                    style: TextStyle(
                      color: general ? AppColors.white : AppColors.navy,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.028,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  general = false;
                  news = true;
                  idea = false;
                  signal = false;
                  meme = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.05,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: news ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.newspaper)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  general = false;
                  news = false;
                  idea = true;
                  signal = false;
                  meme = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.05,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: idea ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.lightBulb)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  general = false;
                  news = false;
                  idea = false;
                  signal = true;
                  meme = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.05,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: signal ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.chartIncreasing)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  general = false;
                  news = false;
                  idea = false;
                  signal = false;
                  meme = true;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.05,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: meme ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.clownFace)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
