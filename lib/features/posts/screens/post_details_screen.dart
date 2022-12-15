import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/posts/widgets/comment_card_view.dart';
import 'package:dangoz/features/posts/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class PostDetailsScreen extends ConsumerStatefulWidget {
  String postId;
  String posterId;

  PostDetailsScreen({
    super.key,
    required this.postId,
    required this.posterId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsScreenState();
}

class _PostDetailsScreenState extends ConsumerState<PostDetailsScreen> {
  late Future commentsSnapshot;
  late Future postSnapshot;
  @override
  void initState() {
    super.initState();
    getPostComments();
    getPostData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getPostData() {
    postSnapshot =
        FirebaseFirestore.instance.collection('Posts').doc(widget.postId).get();
    return commentsSnapshot;
  }

  Future getPostComments() {
    commentsSnapshot =
        ref.read(postControllerProvider).getPostComments(widget.postId);
    return commentsSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.navy),
      body: FutureBuilder(
        future: ref
            .read(postControllerProvider)
            .userDataByIdFuture(widget.posterId),
        builder: (BuildContext context, AsyncSnapshot userSnapshot) {
          if (userSnapshot.data == null) {
            return const SizedBox();
          }
          var userData = userSnapshot.data.docs[0];
          return FutureBuilder(
            future: postSnapshot,
            builder: (BuildContext context, AsyncSnapshot postSnapshot) {
              if (postSnapshot.data == null) {
                return const SizedBox();
              }
              var postData = postSnapshot.data;
              return Container(
                height: Get.height,
                width: Get.width,
                color: AppColors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PostCard(
                        postId: widget.postId,
                        posterId: widget.posterId,
                        name: userData['name'],
                        userName: userData['userName'],
                        profileUrl: userData['profileImage'],
                        post: postData['post'],
                        gifUrl: postData['gifUrl'],
                        imageUrl: postData['imageUrl'],
                        videoUrl: postData['videoUrl'],
                        timePosted: DateTime.fromMillisecondsSinceEpoch(
                            postData['timePosted']),
                        verified: userData['isVerified'],
                        sponsered: postData['isSponsered'],
                        isRepost: postData['isRepost'],
                        reposterId: postData['reposterId'],
                        general: postData['isGeneralPost'],
                        news: postData['isNewsPost'],
                        idea: postData['isIdeasPost'],
                        signal: postData['isSignalPost'],
                        meme: postData['isMemePost'],
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                          future: commentsSnapshot,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
                            } else {
                              int snapshotLength = snapshot.data.docs.length;
                              return Container(
                                height: Get.height * 0.782,
                                child: LiquidPullToRefresh(
                                  color: AppColors.navy,
                                  height: Get.height * 0.2,
                                  showChildOpacityTransition: false,
                                  onRefresh: () async {
                                    setState(() {
                                      commentsSnapshot = getPostComments();
                                    });
                                  },
                                  child: ListView.builder(
                                    itemCount: snapshotLength,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var commentData =
                                          snapshot.data.docs[index];
                                      return CommentCardView(
                                        postId: widget.postId,
                                        commentId: commentData['commentId'],
                                        commenterId: commentData['userId'],
                                        commentDate: commentData['commentedAt'],
                                        comment: commentData['comment'],
                                        imageUrl: commentData['imageUrl'],
                                        gifUrl: commentData['gifUrl'],
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
