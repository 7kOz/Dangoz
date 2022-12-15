import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/posts/controller/getx_category_controller.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/posts/screens/replies_to_comment_listview.dart';
import 'package:dangoz/features/posts/widgets/reply_to_comment_card_view.dart';
import 'package:dangoz/features/profiles/screens/profiles_screen.dart';
import 'package:dangoz/models/comment_model.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCardView extends ConsumerStatefulWidget {
  String postId;
  String commentId;
  String commenterId;
  Timestamp commentDate;
  String comment;
  String imageUrl;
  String gifUrl;
  CommentCardView({
    super.key,
    required this.postId,
    required this.commentId,
    required this.commenterId,
    required this.commentDate,
    required this.comment,
    required this.imageUrl,
    required this.gifUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommentCardViewState();
}

class _CommentCardViewState extends ConsumerState<CommentCardView> {
  late Future commenterDataSnapshot;
  PostCategoryController postCategoryController =
      Get.put(PostCategoryController());
  @override
  void initState() {
    super.initState();
    getCommenterData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getCommenterData() {
    commenterDataSnapshot =
        ref.read(postControllerProvider).userDataByIdFuture(widget.commenterId);
    return commenterDataSnapshot;
  }

  void likeAComment() {
    ref.read(postControllerProvider).likeAComment(
          widget.postId,
          widget.commentId,
          widget.commenterId,
          FirebaseAuth.instance.currentUser!.uid,
        );
  }

  void unLikeAComment() {
    ref.read(postControllerProvider).unLikeAComment(
          widget.postId,
          widget.commentId,
          widget.commenterId,
          FirebaseAuth.instance.currentUser!.uid,
        );
  }

  void disLikeAComment() {
    ref.read(postControllerProvider).disLikeAComment(
          widget.postId,
          widget.commentId,
          widget.commenterId,
          FirebaseAuth.instance.currentUser!.uid,
        );
  }

  void unDisLikeAComment() {
    ref.read(postControllerProvider).unDisLikeAComment(
          widget.postId,
          widget.commentId,
          widget.commenterId,
          FirebaseAuth.instance.currentUser!.uid,
        );
  }

  void deleteComment() {
    ref
        .read(postControllerProvider)
        .deleteComment(widget.postId, widget.commentId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostCategoryController>(
        builder: (postCategoryController) {
      return FutureBuilder(
          future: commenterDataSnapshot,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              var commenterData = snapshot.data.docs[0];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => RepliesToCommentListView(
                        postId: widget.postId,
                        commentId: widget.commentId,
                        commenterId: widget.commenterId,
                        name: commenterData['name'],
                        userName: commenterData['userName'],
                        profileImage: commenterData['profileImage'],
                        comment: widget.comment,
                        gifUrl: widget.gifUrl,
                        imageUrl: widget.imageUrl,
                        commentedAt: widget.commentDate,
                        commenterVerified: commenterData['isVerified'],
                      ),
                    );
                  },
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Container(
                    width: Get.width,
                    child: Column(
                      children: [
                        commentViewHeader(
                          commenterData['uid'],
                          commenterData['profileImage'],
                          commenterData['name'],
                          commenterData['isPro'],
                          commenterData['userName'],
                          DateTime.parse(
                              widget.commentDate.toDate().toString()),
                        ),
                        const SizedBox(height: 10),
                        commentBody(),
                        const SizedBox(height: 20),
                        commentFooter(),
                        const SizedBox(height: 10),
                        Divider(color: AppColors.navy),
                      ],
                    ),
                  ),
                ),
              );
            }
          });
    });
  }

  Widget commentViewHeader(
      String commenterId,
      String commenterImage,
      String commenterName,
      bool commenterVerified,
      String commenterUserName,
      DateTime commentedAt) {
    return Container(
      height: Get.height * 0.08,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              widget.commenterId == ''
                  ? InkWell(
                      onTap: () {
                        Get.to(() => ProfilesScreen(
                              profileId: commenterId,
                            ));
                      },
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
                      onTap: () {
                        Get.to(() => ProfilesScreen(
                              profileId: commenterId,
                            ));
                      },
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: CircleAvatar(
                        radius: Get.height * 0.03,
                        backgroundImage: NetworkImage(
                          commenterImage,
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
                        commenterName,
                        style: TextStyle(
                          color: AppColors.navy,
                          letterSpacing: 1,
                          fontSize: Get.width * 0.0325,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      commenterVerified == true
                          ? Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: AppColors.green,
                              size: Get.width * 0.04,
                            )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(height: 2),
                  Container(
                    height: Get.height * 0.02,
                    width: Get.width * 0.16,
                    color: AppColors.white,
                    child: Center(
                        child: Text(
                      '@$commenterUserName',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: Get.width * 0.03,
                      ),
                    )),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              commenterId == FirebaseAuth.instance.currentUser!.uid
                  ? InkWell(
                      onTap: deleteComment,
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Icon(
                        CupertinoIcons.delete_left_fill,
                        color: AppColors.red,
                        size: Get.width * 0.04,
                      ),
                    )
                  : const SizedBox(),
              commenterId == FirebaseAuth.instance.currentUser!.uid
                  ? const Spacer()
                  : const SizedBox(),
              Text(
                timeago.format(commentedAt, locale: 'en_short'),
                style: TextStyle(
                  color: AppColors.lightGrey,
                  letterSpacing: 1,
                  fontSize: Get.width * 0.0275,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget commentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.comment,
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
                          height: widget.gifUrl == ''
                              ? Get.height * 0.2
                              : Get.height * 0.2,
                          width: widget.gifUrl == ''
                              ? Get.width * 0.65
                              : Get.width * 0.45,
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
                          height: widget.imageUrl == ''
                              ? Get.height * 0.2
                              : Get.height * 0.2,
                          width: widget.imageUrl == ''
                              ? Get.width * 0.5
                              : Get.width * 0.4,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget commentFooter() {
    return StreamBuilder(
        stream: ref
            .read(postControllerProvider)
            .commentDataById(widget.postId, widget.commentId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.data == null) {
            return const SizedBox();
          } else {
            var commentData = snapshot.data;

            return Container(
              height: Get.height * 0.02,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StreamBuilder(
                            stream: ref
                                .read(postControllerProvider)
                                .commentsLikesInteractionsStream(
                                    widget.commentId),
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
                                onTap: isLiked == true
                                    ? unLikeAComment
                                    : likeAComment,
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
                          NumberFormat.compact().format(commentData['likes']),
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: Get.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(
                            CupertinoIcons.chat_bubble,
                            color: AppColors.navy,
                            size: Get.width * 0.05,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          NumberFormat.compact().format(commentData['replies']),
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: Get.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StreamBuilder(
                            stream: ref
                                .read(postControllerProvider)
                                .commentsDisLikesInteractionsStream(
                                    widget.commentId),
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
                                    ? unDisLikeAComment
                                    : disLikeAComment,
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
                          NumberFormat.compact()
                              .format(commentData['dislikes']),
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: Get.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
