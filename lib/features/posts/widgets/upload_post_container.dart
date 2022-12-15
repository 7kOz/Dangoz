import 'dart:io';
import 'dart:typed_data';

import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/utils.dart';
import 'package:dangoz/features/posts/controller/getx_category_controller.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:emojis/emojis.dart';
import 'package:emojis/emoji.dart';

import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadPostContainer extends ConsumerStatefulWidget {
  const UploadPostContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<UploadPostContainer> createState() =>
      _UploadPostContainerState();
}

class _UploadPostContainerState extends ConsumerState<UploadPostContainer> {
  PostCategoryController postCategoryController =
      Get.put(PostCategoryController());
  TextEditingController post = TextEditingController();
  File? image;
  File? video;
  GiphyGif? gif;
  Uint8List? videoThumbnail;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      post.text = '';
      post.clear();
      image = null;
      video = null;
      gif = null;
      videoThumbnail = null;
    });
  }

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void selectVideo() async {
    video = await pickVideoFromGallery();
    videoThumbnail = await VideoThumbnail.thumbnailData(
      video: video!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
    setState(() {});
  }

  void selectGIF() async {
    gif = await pickGIF(context);
    setState(() {});
  }

  void saveGeneralPostToDb(
    String post,
    String? gifUrl,
    File? image,
    File? video,
    bool isGeneralPost,
    bool isNewsPost,
    bool isIdeasPost,
    bool isSignalPost,
    bool isMemePost,
  ) {
    ref.read(postControllerProvider).saveGeneralPostToDb(
          FirebaseAuth.instance.currentUser!.uid,
          post,
          gifUrl!,
          image,
          video,
          isGeneralPost,
          isNewsPost,
          isIdeasPost,
          isSignalPost,
          isMemePost,
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
                            controller: post,
                            cursorColor: AppColors.navy,
                            maxLength: 350,
                            maxLines: 20,
                            decoration: InputDecoration(
                              hintText: 'New Post',
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
                                    fit: BoxFit.fill,
                                    height: Get.height * 0.075,
                                    width: Get.width * 0.25,
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
                              height: Get.height * 0.075,
                              width: Get.width * 0.25,
                              child: GiphyImageView(
                                gif: gif!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(width: 10),
                    videoThumbnail != null
                        ? Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Image.memory(
                                        videoThumbnail as Uint8List,
                                        height: Get.height * 0.075,
                                        width: Get.width * 0.25,
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                          right: Get.width * 0.1,
                                          top: Get.height * 0.0275,
                                          child: Icon(
                                            Icons.play_circle,
                                            color: AppColors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
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
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: selectVideo,
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Icon(
                        Icons.video_camera_back,
                        color: AppColors.navy,
                        size: Get.width * 0.07,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (post.text != '' ||
                            image != null ||
                            gif != null ||
                            video != null) {
                          saveGeneralPostToDb(
                            post.text,
                            gif == null ? '' : gif!.url,
                            image == null ? File('') : image as File,
                            video == null ? File('') : video as File,
                            postCategoryController.isGeneralPost,
                            postCategoryController.isNewsPost,
                            postCategoryController.isIdeasPost,
                            postCategoryController.isSignalPost,
                            postCategoryController.isMemePost,
                          );
                          setState(() {
                            post.text = '';
                            post.clear();
                            gif = null;
                            image = null;
                            video = null;
                            videoThumbnail = null;
                          });
                          postCategoryController.clearCategories();
                        } else {
                          Get.snackbar('Oops', 'Ghosts Can\'t View This',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white);
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
                            'Post',
                            style: TextStyle(
                              color: AppColors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            postCategory(postCategoryController),
          ],
        ),
      ),
    );
  }

  Widget postCategory(PostCategoryController postCategoryController) {
    return GetBuilder<PostCategoryController>(
        builder: (postCategoryController) {
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
                  postCategoryController.onGeneralPost();
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: postCategoryController.isGeneralPost
                        ? AppColors.navy
                        : AppColors.white,
                    border: Border.all(color: AppColors.navy),
                  ),
                  child: Center(
                    child: Text(
                      'General',
                      style: TextStyle(
                        color: postCategoryController.isGeneralPost
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
                  postCategoryController.onNewsPost();
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: postCategoryController.isNewsPost
                        ? AppColors.navy
                        : AppColors.white,
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
                  postCategoryController.onIdeasPost();
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: postCategoryController.isIdeasPost
                        ? AppColors.navy
                        : AppColors.white,
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
                  postCategoryController.onSignalPost();
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: postCategoryController.isSignalPost
                        ? AppColors.navy
                        : AppColors.white,
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
                  postCategoryController.onMemePost();
                },
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: postCategoryController.isMemePost
                        ? AppColors.navy
                        : AppColors.white,
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
    });
  }
}
