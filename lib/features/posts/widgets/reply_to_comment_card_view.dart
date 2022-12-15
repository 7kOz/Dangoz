import 'dart:io';

import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/utils.dart';
import 'package:dangoz/features/posts/controller/getx_category_controller.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ReplyToCommentCardView extends ConsumerStatefulWidget {
  String postId;
  String commentId;
  String commenterId;
  String commenterUserName;

  ReplyToCommentCardView({
    super.key,
    required this.postId,
    required this.commentId,
    required this.commenterId,
    required this.commenterUserName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReplyToCommentCardViewState();
}

class _ReplyToCommentCardViewState
    extends ConsumerState<ReplyToCommentCardView> {
  PostCategoryController postCategoryController =
      Get.put(PostCategoryController());
  TextEditingController reply = TextEditingController();
  File? image;
  GiphyGif? gif;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    reply.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void selectGIF() async {
    gif = await pickGIF(context);
    setState(() {});
  }

  void replyToAComment() {
    ref.read(postControllerProvider).replyOnAComment(
          widget.postId,
          widget.commentId,
          widget.commenterId,
          reply.text,
          gif == null ? '' : gif!.url,
          image,
        );
  }

  @override
  Widget build(BuildContext context) {
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
                            controller: reply,
                            cursorColor: AppColors.navy,
                            maxLength: 200,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText:
                                  'Replying to @${widget.commenterUserName}',
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
                        if (reply.text != '' || image != null || gif != null) {
                          replyToAComment();
                          setState(() {
                            reply.text = '';
                            reply.clear();
                            gif = null;
                            image = null;
                          });
                          Get.snackbar(
                            '🥳',
                            'Reply Posted',
                            backgroundColor: AppColors.green,
                            colorText: AppColors.white,
                          );
                          postCategoryController.toggleReplyToCommentBox();
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
                            'Reply',
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
}
