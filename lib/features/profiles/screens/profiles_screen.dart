import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/features/chat/screens/chat_screen.dart';
import 'package:dangoz/features/posts/widgets/post_card.dart';
import 'package:dangoz/features/profiles/controller/profiles_controller.dart';
import 'package:dangoz/features/profiles/widgets/follow_unfollow_widget.dart';
import 'package:dangoz/features/profiles/widgets/following_followers_table.dart';
import 'package:dangoz/features/profiles/widgets/profile_Image.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProfilesScreen extends ConsumerStatefulWidget {
  String profileId;
  ProfilesScreen({Key? key, required this.profileId}) : super(key: key);

  @override
  ConsumerState<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends ConsumerState<ProfilesScreen> {
  bool following = true;

  Future getAllPosts() {
    var allPosts =
        ref.read(profilesControllerProvider).allPosts(widget.profileId);
    return allPosts;
  }

  @override
  void initState() {
    super.initState();
    getAllPosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream:
          ref.read(profilesControllerProvider).userDataById(widget.profileId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        UserModel user = snapshot.data;
        int totalPosts = user.generalPosts +
            user.cryptoGeneralPosts +
            user.forexGeneralPosts +
            user.stocksGeneralPosts +
            user.cryptoNewsPosts +
            user.forexNewsPosts +
            user.stocksNewsPosts +
            user.cryptoIdeasPosts +
            user.forexIdeasPosts +
            user.stocksIdeasPosts +
            user.cryptoSignalsPosts +
            user.forexSignalsPosts +
            user.stocksSignalsPosts +
            user.cryptoMemesPosts +
            user.forexMemesPosts +
            user.stocksMemesPosts;

        int cryptoPosts = user.cryptoGeneralPosts +
            user.cryptoNewsPosts +
            user.cryptoIdeasPosts +
            user.cryptoSignalsPosts +
            user.cryptoMemesPosts;

        int forexPosts = user.forexGeneralPosts +
            user.forexNewsPosts +
            user.forexIdeasPosts +
            user.forexSignalsPosts +
            user.forexMemesPosts;

        int stocksPosts = user.stocksGeneralPosts +
            user.stocksNewsPosts +
            user.stocksIdeasPosts +
            user.stocksSignalsPosts +
            user.stocksMemesPosts;

        if (snapshot.data == null) {
          return Container(
            color: AppColors.white,
          );
        }
        return StreamBuilder(
            stream: ref.read(profilesControllerProvider).followingStream(),
            builder: (BuildContext context, AsyncSnapshot followersSnapshot) {
              if (followersSnapshot.data == null) {
                return const SizedBox();
              }
              bool following = false;

              int snapshotLength = followersSnapshot.data.docs.length;
              for (int i = 0; i < snapshotLength; i++) {
                if (user.uid == followersSnapshot.data.docs[i]['uid']) {
                  following = true;
                }
              }
              return Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  backgroundColor: AppColors.navy,
                  centerTitle: true,
                  title: Column(
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                      Text(
                        '@${user.userName}',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.width * 0.03,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent),
                        child: InkWell(
                          onTap: () => Get.to(
                              () => ChatScreen(name: user.name, uid: user.uid)),
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(
                            CupertinoIcons.chat_bubble,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * 0.72,
                        width: Get.width,
                        color: AppColors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height * 0.02),
                            ProfileImage(imageUrl: user.profileImage as String),
                            SizedBox(height: Get.height * 0.02),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : userInfo(
                                    user.joined.toString().substring(0, 10),
                                    user.bio,
                                    user.location),
                            user.isPrivate == true && following == false
                                ? SizedBox(
                                    height: Get.height * 0.025,
                                  )
                                : SizedBox(height: Get.height * 0.02),
                            FollowUnfollowWidget(
                                baseId: user.uid, privateUser: user.isPrivate),
                            SizedBox(height: Get.height * 0.02),
                            FollowingsFollowersTable(
                              followings: user.following,
                              followers: user.followers,
                            ),
                            user.isPrivate == true && following == false
                                ? SizedBox(height: Get.height * 0.15)
                                : const SizedBox(),
                            user.isPrivate == true && following == false
                                ? SizedBox(
                                    child: Center(
                                      child: Text(
                                        'Private User',
                                        style: TextStyle(
                                            color: AppColors.navy,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Get.width * 0.04),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : SizedBox(height: Get.height * 0.02),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : Divider(color: AppColors.navy),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : SizedBox(height: Get.height * 0.01),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : postsInfo(totalPosts, cryptoPosts, forexPosts,
                                    stocksPosts, user.generalPosts),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : SizedBox(height: Get.height * 0.01),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : Divider(color: AppColors.navy),
                            user.isPrivate == true && following == false
                                ? const SizedBox()
                                : SizedBox(height: Get.height * 0.02),
                          ],
                        ),
                      ),
                      user.isPrivate == true && following == false
                          ? const SizedBox()
                          : FutureBuilder(
                              future: getAllPosts(),
                              builder: (BuildContext context,
                                  AsyncSnapshot postsSnapshot) {
                                if (postsSnapshot.data == null) {
                                  return Container();
                                }
                                return Container(
                                  height: Get.height * 0.7,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: postsSnapshot.data.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var post =
                                            postsSnapshot.data.docs[index];
                                        return PostCard(
                                          postId: post['postId'],
                                          profileUrl:
                                              user.profileImage as String,
                                          userName: user.name,
                                          posterId: post['posterId'],
                                          post: post['post'],
                                          imageUrl: post['imageUrl'],
                                          name: user.name,
                                          timePosted: DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  post['timePosted']),
                                          verified: true,
                                          sponsered: false,
                                          general: true,
                                          news: false,
                                          idea: false,
                                          signal: false,
                                          meme: false,
                                          gifUrl: post['gifUrl'],
                                          videoUrl: post['videoUrl'],
                                          isRepost: post['isRepost'],
                                          reposterId: post['reposterId'],
                                        );
                                      }),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget userInfo(String joinedAt, String bio, String location) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: Get.height * 0.125,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              bio,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: Get.width * 0.032,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  CupertinoIcons.location,
                  color: AppColors.navy,
                  size: Get.width * 0.05,
                ),
                const SizedBox(width: 10),
                Text(
                  location,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.03,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Joined: ',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.03,
                  ),
                ),
                Text(
                  joinedAt,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget postsInfo(int postsCount, int cryptoPosts, int forexPosts,
      int stocksPosts, int generalPosts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: Get.height * 0.12,
        width: Get.width,
        color: AppColors.white,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Posts',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: Get.width * 0.035,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  postsCount.toString(),
                  style: TextStyle(
                    color: postsCount == 0 ? AppColors.red : AppColors.green,
                    fontSize: Get.width * 0.03,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.navy),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'General',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: Get.width * 0.035,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      generalPosts.toString(),
                      style: TextStyle(
                        color:
                            generalPosts == 0 ? AppColors.red : AppColors.green,
                        fontSize: Get.width * 0.03,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: Get.height * 0.05,
                    child: VerticalDivider(color: AppColors.navy)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Crypto',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: Get.width * 0.035,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cryptoPosts.toString(),
                      style: TextStyle(
                        color:
                            cryptoPosts == 0 ? AppColors.red : AppColors.green,
                        fontSize: Get.width * 0.03,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: Get.height * 0.05,
                    child: VerticalDivider(color: AppColors.navy)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Forex',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: Get.width * 0.035,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      forexPosts.toString(),
                      style: TextStyle(
                        color:
                            forexPosts == 0 ? AppColors.red : AppColors.green,
                        fontSize: Get.width * 0.03,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: Get.height * 0.05,
                    child: VerticalDivider(color: AppColors.navy)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Stocks',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: Get.width * 0.035,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      stocksPosts.toString(),
                      style: TextStyle(
                        color:
                            stocksPosts == 0 ? AppColors.red : AppColors.green,
                        fontSize: Get.width * 0.03,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
