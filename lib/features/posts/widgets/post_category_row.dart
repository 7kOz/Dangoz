import 'package:dangoz/base/app_colors.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PostCategoryRow extends StatefulWidget {
  bool isGeneralPost = false;
  bool isNewsPost = false;
  bool isIdeasPost = false;
  bool isSignalPost = false;
  bool isMemePost = false;
  PostCategoryRow({
    Key? key,
    required this.isGeneralPost,
    required this.isIdeasPost,
    required this.isNewsPost,
    required this.isSignalPost,
    required this.isMemePost,
  }) : super(key: key);

  @override
  State<PostCategoryRow> createState() => _PostCategoryRowState();
}

class _PostCategoryRowState extends State<PostCategoryRow> {
  @override
  Widget build(BuildContext context) {
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
                  widget.isGeneralPost = true;
                  widget.isNewsPost = false;
                  widget.isIdeasPost = false;
                  widget.isSignalPost = false;
                  widget.isMemePost = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.03,
                width: Get.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      widget.isGeneralPost ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    'General',
                    style: TextStyle(
                      color: widget.isGeneralPost
                          ? AppColors.white
                          : AppColors.navy,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.02,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.isGeneralPost = false;
                  widget.isNewsPost = true;
                  widget.isIdeasPost = false;
                  widget.isSignalPost = false;
                  widget.isMemePost = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.03,
                width: Get.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.isNewsPost ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.newspaper)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.03,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.isGeneralPost = false;
                  widget.isNewsPost = false;
                  widget.isIdeasPost = true;
                  widget.isSignalPost = false;
                  widget.isMemePost = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.03,
                width: Get.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.isIdeasPost ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.lightBulb)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.03,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.isGeneralPost = false;
                  widget.isNewsPost = false;
                  widget.isIdeasPost = false;
                  widget.isSignalPost = true;
                  widget.isMemePost = false;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.03,
                width: Get.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.isSignalPost ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.chartIncreasing)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.03,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.isGeneralPost = false;
                  widget.isNewsPost = false;
                  widget.isIdeasPost = false;
                  widget.isSignalPost = false;
                  widget.isMemePost = true;
                });
              },
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: Container(
                height: Get.height * 0.03,
                width: Get.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.isMemePost ? AppColors.navy : AppColors.white,
                  border: Border.all(color: AppColors.navy),
                ),
                child: Center(
                  child: Text(
                    '${Emoji.byChar(Emojis.clownFace)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: Get.width * 0.03,
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
