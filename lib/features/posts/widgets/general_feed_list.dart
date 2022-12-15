import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/posts/controller/post_controller.dart';
import 'package:dangoz/features/posts/widgets/post_card.dart';
import 'package:dangoz/features/posts/widgets/repost/repost_card.dart';
import 'package:dangoz/models/post_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class GeneralFeedsList extends ConsumerStatefulWidget {
  double height;
  GeneralFeedsList({Key? key, required this.height}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GeneralFeedsList();
}

class _GeneralFeedsList extends ConsumerState<GeneralFeedsList> {
  late Future generalFeeds;

  @override
  void initState() {
    super.initState();
    getGeneralFeeds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getGeneralFeeds() async {
    generalFeeds = ref.read(postControllerProvider).generalFeeds();
    return generalFeeds;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: Get.width,
      color: AppColors.white,
      child: FutureBuilder(
        future: generalFeeds,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Container(
            height: widget.height,
            width: Get.width,
            child: LiquidPullToRefresh(
              onRefresh: () async {
                setState(() {
                  generalFeeds =
                      ref.read(postControllerProvider).generalFeeds();
                });
              },
              height: Get.height * 0.2,
              backgroundColor: AppColors.white,
              color: AppColors.navy,
              showChildOpacityTransition: false,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs!.length,
                itemBuilder: (BuildContext context, int index) {
                  var post = snapshot.data.docs[index];
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(post['posterId'])
                          .snapshots(),
                      builder:
                          (BuildContext context, AsyncSnapshot userSnapshot) {
                        if (userSnapshot.data == null) {
                          return Container();
                        }
                        return post['isRepost'] == false
                            ? PostCard(
                                postId: post['postId'],
                                profileUrl: userSnapshot.data['profileImage'],
                                userName: userSnapshot.data['userName'],
                                posterId: post['posterId'],
                                post: post['post'],
                                imageUrl: post['imageUrl'],
                                name: userSnapshot.data['name'],
                                timePosted: DateTime.fromMillisecondsSinceEpoch(
                                    post['timePosted']),
                                verified: userSnapshot.data['isVerified'],
                                sponsered: post['isSponsered'],
                                general: post['isGeneralPost'],
                                news: post['isNewsPost'],
                                idea: post['isIdeasPost'],
                                signal: post['isSignalPost'],
                                meme: post['isMemePost'],
                                gifUrl: post['gifUrl'],
                                videoUrl: post['videoUrl'],
                                isRepost: post['isRepost'],
                                reposterId: post['reposterId'],
                              )
                            : RepostCard(
                                repostId: post['repostId'],
                                postId: post['postId'],
                                reposterId: post['reposterId'],
                                profileUrl: userSnapshot.data['profileImage'],
                                userName: userSnapshot.data['userName'],
                                posterId: post['posterId'],
                                post: post['post'],
                                imageUrl: post['imageUrl'],
                                name: userSnapshot.data['name'],
                                timePosted: DateTime.fromMillisecondsSinceEpoch(
                                    post['timePosted']),
                                verified: userSnapshot.data['isVerified'],
                                sponsered: post['isSponsered'],
                                general: post['isGeneralPost'],
                                news: post['isNewsPost'],
                                idea: post['isIdeasPost'],
                                signal: post['isSignalPost'],
                                meme: post['isMemePost'],
                                gifUrl: post['gifUrl'],
                                videoUrl: post['videoUrl'],
                                isRepost: post['isRepost'],
                              );
                      });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
