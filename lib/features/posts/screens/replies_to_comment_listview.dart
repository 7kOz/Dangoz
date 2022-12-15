import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/posts/widgets/reply_to_comment_card_view.dart';
import 'package:dangoz/features/profiles/screens/profiles_screen.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepliesToCommentListView extends ConsumerWidget {
  String postId;
  String commentId;
  String commenterId;
  String name;
  String userName;
  String profileImage;
  String comment;
  String gifUrl;
  String imageUrl;
  Timestamp commentedAt;
  bool commenterVerified;
  RepliesToCommentListView({
    super.key,
    required this.postId,
    required this.commentId,
    required this.commenterId,
    required this.name,
    required this.userName,
    required this.profileImage,
    required this.comment,
    required this.gifUrl,
    required this.imageUrl,
    required this.commentedAt,
    required this.commenterVerified,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Theme(
          data: ThemeData(highlightColor: Colors.transparent),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Icon(
              CupertinoIcons.chevron_back,
              color: AppColors.navy,
              size: Get.width * 0.06,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: pageHeader(context),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReplyToCommentCardView(
                postId: postId,
                commentId: commentId,
                commenterId: commenterId,
                commenterUserName: userName,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FutureBuilder(
                future: ref
                    .read(postControllerProvider)
                    .repliesToComment(commentId),
                builder: (BuildContext context, AsyncSnapshot replySnapshot) {
                  if (replySnapshot.data == null) {
                    return const SizedBox();
                  }
                  int repliesLength = replySnapshot.data.docs.length;
                  return Container(
                    height: Get.height * 0.8,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: repliesLength,
                      itemBuilder: (BuildContext context, int index) {
                        var replieData = replySnapshot.data.docs[index];
                        return FutureBuilder(
                          future: ref
                              .read(postControllerProvider)
                              .userDataByIdFuture(replieData['userId']),
                          builder: (BuildContext context,
                              AsyncSnapshot userSnapshot) {
                            if (userSnapshot.data == null) {
                              return const SizedBox();
                            }
                            var userData = userSnapshot.data.docs[0];
                            return SizedBox(
                              width: Get.width,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          userData['profileImage'] == ''
                                              ? CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      AppColors.lightGrey,
                                                  child: Center(
                                                    child: Icon(
                                                      CupertinoIcons.person,
                                                      color: AppColors.white,
                                                      size: Get.width * 0.05,
                                                    ),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      AppColors.lightGrey,
                                                  backgroundImage: NetworkImage(
                                                    userData['profileImage'],
                                                  ),
                                                ),
                                          const SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.65,
                                                child: Text(
                                                  userData['name'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.navy,
                                                      fontSize:
                                                          Get.width * 0.03,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width: Get.width * 0.65,
                                                child: Text(
                                                  '@${userData['userName']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.navy,
                                                    fontSize: Get.width * 0.03,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      replieData['userId'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? InkWell(
                                              onTap: () {
                                                ref
                                                    .read(
                                                        postControllerProvider)
                                                    .deleteReplyToComment(
                                                      postId,
                                                      commentId,
                                                      replieData['replyId'],
                                                      commenterId,
                                                    );
                                              },
                                              splashColor: Colors.transparent,
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              child: Icon(
                                                  CupertinoIcons
                                                      .delete_left_fill,
                                                  color: AppColors.red,
                                                  size: Get.width * 0.05),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  replieData['reply'] != ''
                                      ? const SizedBox(height: 20)
                                      : const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(replieData['reply']),
                                      ],
                                    ),
                                  ),
                                  replieData['gifUrl'] != '' ||
                                          replieData['imageUrl'] != ''
                                      ? const SizedBox(height: 20)
                                      : const SizedBox(),
                                  Container(
                                    width: Get.width * 0.9,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        replieData['imageUrl'] == ''
                                            ? const SizedBox()
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: InkWell(
                                                  onTap: () {
                                                    showImageViewer(
                                                      context,
                                                      NetworkImage(replieData[
                                                          'imageUrl']),
                                                      onViewerDismissed: () {},
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true,
                                                    );
                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        replieData['imageUrl'],
                                                    height:
                                                        replieData['gifUrl'] ==
                                                                ''
                                                            ? Get.height * 0.2
                                                            : Get.height * 0.2,
                                                    width:
                                                        replieData['gifUrl'] ==
                                                                ''
                                                            ? Get.width * 0.65
                                                            : Get.width * 0.45,
                                                  ),
                                                ),
                                              ),
                                        const SizedBox(width: 10),
                                        replieData['gifUrl'] == ''
                                            ? const SizedBox()
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: InkWell(
                                                  onTap: () {
                                                    showImageViewer(
                                                      context,
                                                      NetworkImage(
                                                          replieData['gifUrl']),
                                                      onViewerDismissed: () {},
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true,
                                                    );
                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        replieData['gifUrl'],
                                                    height: replieData[
                                                                'imageUrl'] ==
                                                            ''
                                                        ? Get.height * 0.2
                                                        : Get.height * 0.2,
                                                    width: replieData[
                                                                'imageUrl'] ==
                                                            ''
                                                        ? Get.width * 0.5
                                                        : Get.width * 0.4,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: StreamBuilder(
                                        stream: ref
                                            .read(postControllerProvider)
                                            .repliestDataSteam(
                                              commentId,
                                              replieData['replyId'],
                                            ),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.data == null) {
                                            return const SizedBox();
                                          } else {
                                            var replyData = snapshot.data;

                                            return Container(
                                              height: Get.height * 0.02,
                                              width: Get.width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        StreamBuilder(
                                                            stream: ref
                                                                .read(
                                                                    postControllerProvider)
                                                                .repliesToCommentsLikesInteractionsStream(
                                                                    replieData[
                                                                        'replyId']),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot
                                                                    snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return const SizedBox();
                                                              }
                                                              bool isLiked =
                                                                  false;
                                                              List likesList =
                                                                  [];
                                                              int snapshotLength =
                                                                  snapshot
                                                                      .data
                                                                      .docs
                                                                      .length;
                                                              for (int i = 0;
                                                                  i < snapshotLength;
                                                                  i++) {
                                                                likesList.add(snapshot
                                                                        .data
                                                                        .docs[i]
                                                                    ['userId']);
                                                              }
                                                              likesList.contains(
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                  ? isLiked =
                                                                      true
                                                                  : isLiked =
                                                                      false;
                                                              return InkWell(
                                                                onTap:
                                                                    isLiked ==
                                                                            true
                                                                        ? () {
                                                                            ref.read(postControllerProvider).unLikeAReplyToAComment(
                                                                                  replieData['userId'],
                                                                                  postId,
                                                                                  commentId,
                                                                                  replieData['replyId'],
                                                                                );
                                                                          }
                                                                        : () {
                                                                            ref.read(postControllerProvider).likeAReplyToAComment(
                                                                                  replieData['userId'],
                                                                                  postId,
                                                                                  commentId,
                                                                                  replieData['replyId'],
                                                                                );
                                                                          },
                                                                child: Icon(
                                                                  isLiked ==
                                                                          true
                                                                      ? CupertinoIcons
                                                                          .heart_fill
                                                                      : CupertinoIcons
                                                                          .heart,
                                                                  color: isLiked ==
                                                                          true
                                                                      ? AppColors
                                                                          .green
                                                                      : AppColors
                                                                          .navy,
                                                                  size:
                                                                      Get.width *
                                                                          0.05,
                                                                ),
                                                              );
                                                            }),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          NumberFormat.compact()
                                                              .format(replyData[
                                                                  'likes']),
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.green,
                                                            fontSize:
                                                                Get.width *
                                                                    0.03,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {},
                                                          splashColor: Colors
                                                              .transparent,
                                                          splashFactory: NoSplash
                                                              .splashFactory,
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .chat_bubble,
                                                            color:
                                                                AppColors.navy,
                                                            size: Get.width *
                                                                0.05,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          NumberFormat.compact()
                                                              .format(replyData[
                                                                  'replies']),
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.navy,
                                                            fontSize:
                                                                Get.width *
                                                                    0.03,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        StreamBuilder(
                                                            stream: ref
                                                                .read(
                                                                    postControllerProvider)
                                                                .repliesToCommentsDisLikesInteractionsStream(
                                                                    replieData[
                                                                        'replyId']),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot
                                                                    snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                return const SizedBox();
                                                              }
                                                              bool isDisLiked =
                                                                  false;

                                                              List
                                                                  disLikesList =
                                                                  [];
                                                              int snapshotLength =
                                                                  snapshot
                                                                      .data
                                                                      .docs
                                                                      .length;
                                                              for (int i = 0;
                                                                  i < snapshotLength;
                                                                  i++) {
                                                                disLikesList.add(snapshot
                                                                        .data
                                                                        .docs[i]
                                                                    ['userId']);
                                                              }
                                                              disLikesList.contains(
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                  ? isDisLiked =
                                                                      true
                                                                  : isDisLiked =
                                                                      false;
                                                              return InkWell(
                                                                onTap:
                                                                    isDisLiked ==
                                                                            true
                                                                        ? () {
                                                                            ref.read(postControllerProvider).unDisLikeAReplyToAComment(
                                                                                  replieData['userId'],
                                                                                  postId,
                                                                                  commentId,
                                                                                  replieData['replyId'],
                                                                                );
                                                                          }
                                                                        : () {
                                                                            ref.read(postControllerProvider).disLikeAReplyToAComment(
                                                                                  replieData['userId'],
                                                                                  postId,
                                                                                  commentId,
                                                                                  replieData['replyId'],
                                                                                );
                                                                          },
                                                                child: Icon(
                                                                  isDisLiked ==
                                                                          true
                                                                      ? CupertinoIcons
                                                                          .hand_thumbsdown_fill
                                                                      : CupertinoIcons
                                                                          .hand_thumbsdown,
                                                                  color: isDisLiked ==
                                                                          true
                                                                      ? AppColors
                                                                          .red
                                                                      : AppColors
                                                                          .navy,
                                                                  size:
                                                                      Get.width *
                                                                          0.05,
                                                                ),
                                                              );
                                                            }),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          NumberFormat.compact()
                                                              .format(replyData[
                                                                  'dislikes']),
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.red,
                                                            fontSize:
                                                                Get.width *
                                                                    0.03,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                  const SizedBox(height: 10),
                                  divider(),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        color: AppColors.lightGrey,
        thickness: 0.5,
      ),
    );
  }

  Widget pageHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height * 0.08,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  commenterId == ''
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
                              profileImage,
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
                            name,
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
                          '@$userName',
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
                          // onTap: (deleteComment){},
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
                    timeago.format(
                        DateTime.parse(commentedAt.toDate().toString()),
                        locale: 'en_short'),
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
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment,
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
                              height: gifUrl == ''
                                  ? Get.height * 0.2
                                  : Get.height * 0.2,
                              width: gifUrl == ''
                                  ? Get.width * 0.65
                                  : Get.width * 0.45,
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
                              height: imageUrl == ''
                                  ? Get.height * 0.2
                                  : Get.height * 0.2,
                              width: imageUrl == ''
                                  ? Get.width * 0.5
                                  : Get.width * 0.4,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
