import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/base/app_colors.dart';
import 'package:dangoz/base/repositories/firebase_storage_repository.dart';
import 'package:dangoz/base/repositories/notifications_repository.dart';
import 'package:dangoz/features/notifications/controller/notifications_controller.dart';
import 'package:dangoz/models/comment_model.dart';
import 'package:dangoz/models/post_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

final postRepositoryProvider = Provider(
  (ref) => PostRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class PostRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  PostRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<UserModel> userData(String userUid) {
    return firestore.collection('Users').doc(userUid).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  Future userDataByIdFuture(String userUid) {
    return firestore.collection('Users').where('uid', isEqualTo: userUid).get();
  }

  Stream<PostModel> postData(String postId) {
    return firestore
        .collection('Posts')
        .doc(postId)
        .snapshots()
        .map((event) => PostModel.fromMap(event.data()!));
  }

  Stream postLikesInteractionsStream(String postId) {
    return firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Likes')
        .snapshots();
  }

  Stream postDisLikesInteractionsStream(String postId) {
    return firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Dislikes')
        .snapshots();
  }

  Stream commentData(String postId, String commentId) {
    return firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .snapshots();
  }

  Stream commentsLikesInteractionsStream(String commentId) {
    return firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Likes')
        .snapshots();
  }

  Stream commentsDisLikesInteractionsStream(String commentId) {
    return firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Dislikes')
        .snapshots();
  }

  void saveGeneralPostToDb(
    String posterId,
    String post,
    String? gifUrl,
    File? image,
    File? video,
    ProviderRef ref,
    bool isGeneralPost,
    bool isNewsPost,
    bool isIdeasPost,
    bool isSignalPost,
    bool isMemePost,
  ) async {
    String postId = const Uuid().v1();
    String imageUrl = '';
    String videoUrl = '';
    String newGIFURL = '';

    if (gifUrl != '') {
      int gifURLPartIndex = gifUrl!.lastIndexOf('-') + 1;
      String gifURLPart = gifUrl.substring(gifURLPartIndex);
      newGIFURL = 'https://i.giphy.com/media/$gifURLPart/200.gif';
    }

    if (image!.path != '') {
      imageUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'Posts/$posterId/IMAGES/$postId',
            image,
          );
    }

    if (video!.path != '') {
      videoUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'Posts/$posterId/VIDEO/$postId',
            video,
          );
    }

    var postData = PostModel(
      postId: postId,
      posterId: posterId,
      post: post,
      gifUrl: newGIFURL,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      timePosted: DateTime.now(),
      isSponsered: false,
      isFlagged: false,
      deleted: false,
      isGeneralPost: isGeneralPost,
      isNewsPost: isNewsPost,
      isIdeasPost: isIdeasPost,
      isSignalPost: isSignalPost,
      isMemePost: isMemePost,
      forexGeneralPost: false,
      cryptoGeneralPost: false,
      stocksGeneralPost: false,
      forexNewsPost: false,
      cryptoNewsPost: false,
      stocksNewsPost: false,
      forexIdeasPost: false,
      cryptoIdeasPost: false,
      stocksIdeasPost: false,
      forexSignalsPost: false,
      cryptoSignalsPost: false,
      stocksSignalsPost: false,
      forexMemesPost: false,
      cryptoMemesPost: false,
      stocksMemesPost: false,
      likes: 0,
      comments: 0,
      dislikes: 0,
      reposts: 0,
      isRepost: false,
      repostId: '',
      reposterId: '',
    );

    try {
      await firestore.collection('Posts').doc(postId).set(postData.toMap());
      if (isGeneralPost) {
        await firestore.collection('Users').doc(posterId).update({
          'generalPosts': FieldValue.increment(1),
        });
      } else if (isNewsPost) {
        await firestore.collection('Users').doc(posterId).update({
          'newsPosts': FieldValue.increment(1),
        });
      } else if (isIdeasPost) {
        await firestore.collection('Users').doc(posterId).update({
          'ideasPosts': FieldValue.increment(1),
        });
      } else if (isSignalPost) {
        await firestore.collection('Users').doc(posterId).update({
          'signalPosts': FieldValue.increment(1),
        });
      } else if (isMemePost) {
        await firestore.collection('Users').doc(posterId).update({
          'memePosts': FieldValue.increment(1),
        });
      }
    } catch (e) {
      Get.snackbar('Oops', e.toString(),
          backgroundColor: AppColors.red, colorText: AppColors.white);
    }
  }

  Future getGeneralFeeds() async {
    var generalFeeds = await firestore
        .collection('Posts')
        .where('deleted', isEqualTo: false)
        .get();

    return generalFeeds;
  }

  Future getPostComments(String postId) async {
    var getPostComments = await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .orderBy('likes', descending: true)
        .where('deleted', isEqualTo: false)
        .get();

    return getPostComments;
  }

  void likeAPost(
    String postId,
    String posterId,
    String userId,
    ProviderRef ref,
  ) async {
    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Likes')
        .doc(userId)
        .set({
      'userId': userId,
      'likedAt': DateTime.now(),
    });

    await firestore.collection('Posts').doc(postId).update({
      'likes': FieldValue.increment(1),
    });

    ref.read(notificationsControllerProvider).likedYourPost(posterId, postId);
    //Add Send Notification
  }

  void unLikeAPost(
    String postId,
    String posterId,
    String userId,
    ProviderRef ref,
  ) async {
    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Likes')
        .doc(userId)
        .delete();
    await firestore.collection('Posts').doc(postId).update({
      'likes': FieldValue.increment(-1),
    });

    ref.read(notificationsControllerProvider).unLikedYourPost(posterId, postId);
    //Add Send Notification
  }

  void disLikeAPost(
    String postId,
    String posterId,
    String userId,
    ProviderRef ref,
  ) async {
    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Dislikes')
        .doc(userId)
        .set({
      'userId': userId,
      'disLikedAt': DateTime.now(),
    });

    await firestore.collection('Posts').doc(postId).update({
      'dislikes': FieldValue.increment(1),
    });
    ref
        .read(notificationsControllerProvider)
        .disLikedYourPost(posterId, postId);
    //Add Send Notification
  }

  void unDisLikeAPost(
    String postId,
    String posterId,
    String userId,
    ProviderRef ref,
  ) async {
    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Dislikes')
        .doc(userId)
        .delete();
    await firestore.collection('Posts').doc(postId).update({
      'dislikes': FieldValue.increment(-1),
    });

    ref
        .read(notificationsControllerProvider)
        .unDisLikedYourPost(posterId, postId);

    //Add Send Notification
  }

  void repostAPost(
    String postId,
    String posterId,
    String userId,
    String post,
    String? gifUrl,
    File? image,
    File? video,
    ProviderRef ref,
    bool isGeneralPost,
    bool isNewsPost,
    bool isIdeasPost,
    bool isSignalPost,
    bool isMemePost,
  ) async {
    String repostId = const Uuid().v1();
    String imageUrl = '';
    String videoUrl = '';
    String newGIFURL = '';

    if (gifUrl != '') {
      int gifURLPartIndex = gifUrl!.lastIndexOf('-') + 1;
      String gifURLPart = gifUrl.substring(gifURLPartIndex);
      newGIFURL = 'https://i.giphy.com/media/$gifURLPart/200.gif';
    }

    if (image!.path != '') {
      imageUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'RePosts/$userId/IMAGES/$repostId',
            image,
          );
    }

    if (video!.path != '') {
      videoUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'RePosts/$userId/VIDEO/$repostId',
            video,
          );
    }

    var postData = PostModel(
      postId: repostId,
      posterId: posterId,
      post: post,
      gifUrl: newGIFURL,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      timePosted: DateTime.now(),
      isSponsered: false,
      isFlagged: false,
      isGeneralPost: isGeneralPost == false &&
              isNewsPost == false &&
              isIdeasPost == false &&
              isSignalPost == false &&
              isMemePost == false
          ? true
          : isGeneralPost,
      deleted: false,
      isNewsPost: isNewsPost,
      isIdeasPost: isIdeasPost,
      isSignalPost: isSignalPost,
      isMemePost: isMemePost,
      forexGeneralPost: false,
      cryptoGeneralPost: false,
      stocksGeneralPost: false,
      forexNewsPost: false,
      cryptoNewsPost: false,
      stocksNewsPost: false,
      forexIdeasPost: false,
      cryptoIdeasPost: false,
      stocksIdeasPost: false,
      forexSignalsPost: false,
      cryptoSignalsPost: false,
      stocksSignalsPost: false,
      forexMemesPost: false,
      cryptoMemesPost: false,
      stocksMemesPost: false,
      likes: 0,
      comments: 0,
      dislikes: 0,
      reposts: 0,
      isRepost: true,
      repostId: postId,
      reposterId: userId,
    );
    try {
      await firestore.collection('Posts').doc(repostId).set(postData.toMap());
      if (isGeneralPost) {
        await firestore.collection('Users').doc(userId).update({
          'generalPosts': FieldValue.increment(1),
        });
      } else if (isNewsPost) {
        await firestore.collection('Users').doc(userId).update({
          'newsPosts': FieldValue.increment(1),
        });
      } else if (isIdeasPost) {
        await firestore.collection('Users').doc(userId).update({
          'ideasPosts': FieldValue.increment(1),
        });
      } else if (isSignalPost) {
        await firestore.collection('Users').doc(userId).update({
          'signalPosts': FieldValue.increment(1),
        });
      } else if (isMemePost) {
        await firestore.collection('Users').doc(userId).update({
          'memePosts': FieldValue.increment(1),
        });
      }
    } catch (e) {
      Get.snackbar('Oops', e.toString(),
          backgroundColor: AppColors.red, colorText: AppColors.white);
    }
    await firestore.collection('Posts').doc(postId).update({
      'reposts': FieldValue.increment(1),
    });

    var repostSnap = await firestore.collection('Posts').doc(repostId).get();

    String baseId = repostSnap['posterId'];

    ref.read(notificationsControllerProvider).repostedYourPost(baseId, postId);
  }

  void commentOnAPost(
    String postId,
    String posterId,
    String userId,
    String comment,
    String? gifUrl,
    File? image,
    ProviderRef ref,
  ) async {
    String commentId = Uuid().v1();
    String imageUrl = '';
    String newGIFURL = '';

    if (gifUrl != '') {
      int gifURLPartIndex = gifUrl!.lastIndexOf('-') + 1;
      String gifURLPart = gifUrl.substring(gifURLPartIndex);
      newGIFURL = 'https://i.giphy.com/media/$gifURLPart/200.gif';
    }

    if (image != null) {
      if (image.path != '') {
        imageUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'Comments/$userId/IMAGES/$postId/$commentId',
              image,
            );
      }
    }

    try {
      await firestore
          .collection('PostsInteractions')
          .doc(postId)
          .collection('Comments')
          .doc(commentId)
          .set({
        'commentId': commentId,
        'postId': postId,
        'userId': userId,
        'commentedAt': DateTime.now(),
        'comment': comment,
        'gifUrl': newGIFURL,
        'imageUrl': imageUrl,
        'likes': 0,
        'dislikes': 0,
        'replies': 0,
        'deleted': false,
      });
      await firestore.collection('Posts').doc(postId).update({
        'comments': FieldValue.increment(1),
      });

      ref
          .read(notificationsControllerProvider)
          .commentedOnYourPost(posterId, postId, commentId);
    } catch (e) {
      print(e);
    }

    //Add Notification
  }

  void likeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) async {
    await firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Likes')
        .doc(userId)
        .set({
      'userId': userId,
      'likedAt': DateTime.now(),
    });

    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .update({
      'likes': FieldValue.increment(1),
    });

    //Add Send Notification
  }

  void unLikeComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) async {
    await firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Likes')
        .doc(userId)
        .delete();

    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .update({
      'likes': FieldValue.increment(-1),
    });
    //Add Send Notification
  }

  void disLikeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) async {
    await firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Dislikes')
        .doc(userId)
        .set({
      'userId': userId,
      'disLikedAt': DateTime.now(),
    });

    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .update({
      'dislikes': FieldValue.increment(1),
    });

    //Add Send Notification
  }

  void unDisLikeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) async {
    await firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Dislikes')
        .doc(userId)
        .delete();

    await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .update({
      'dislikes': FieldValue.increment(-1),
    });

    //Add Send Notification
  }

  void deletePost(String postId, String posterId, ProviderRef ref,
      String imageUrl, String videoUrl) async {
    if (posterId == auth.currentUser!.uid) {
      await firestore.collection('Posts').doc(postId).update({
        'deleted': true,
      });
      ref
          .read(commonFirebaseStorageRepositoryProvider)
          .deletePostFilesFromStorage(posterId, postId, imageUrl, videoUrl);
    }
  }

  void deleteComment(String postId, String commentId, ProviderRef ref) async {
    try {
      var postSnap = await firestore.collection('Posts').doc(postId).get();

      String baseId = postSnap['reposterId'] == ''
          ? postSnap['posterId']
          : postSnap['reposterId'];

      await firestore
          .collection('PostsInteractions')
          .doc(postId)
          .collection('Comments')
          .doc(commentId)
          .update({
        'deleted': true,
      });

      await firestore.collection('Posts').doc(postId).update({
        'comments': FieldValue.increment(-1),
      });

      ref
          .read(notificationsControllerProvider)
          .unCommentOnYourPost(baseId, postId, commentId);

      Get.snackbar('Comment Deleted', 'Your Comment Was Deleted Successfully',
          backgroundColor: AppColors.green, colorText: AppColors.white);
    } catch (e) {
      print(e);
    }
  }

  void replyOnAComment(
    String postId,
    String commentId,
    String commenterId,
    String reply,
    String? gifUrl,
    File? image,
    ProviderRef ref,
  ) async {
    String replyId = Uuid().v1();
    String imageUrl = '';
    String newGIFURL = '';

    if (gifUrl != '') {
      int gifURLPartIndex = gifUrl!.lastIndexOf('-') + 1;
      String gifURLPart = gifUrl.substring(gifURLPartIndex);
      newGIFURL = 'https://i.giphy.com/media/$gifURLPart/200.gif';
    }

    if (image != null) {
      if (image.path != '') {
        imageUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'Replies/${auth.currentUser!.uid}/IMAGES/$postId/$commentId/$replyId',
              image,
            );
      }
    }

    try {
      await firestore
          .collection('CommentsInteractions')
          .doc(commentId)
          .collection('Replies')
          .doc(replyId)
          .set({
        'commentId': commentId,
        'postId': postId,
        'userId': auth.currentUser!.uid,
        'repliedAt': DateTime.now(),
        'reply': reply,
        'gifUrl': newGIFURL,
        'imageUrl': imageUrl,
        'likes': 0,
        'dislikes': 0,
        'replies': 0,
        'deleted': false,
        'replyId': replyId,
      });
      await firestore
          .collection('PostsInteractions')
          .doc(postId)
          .collection('Comments')
          .doc(commentId)
          .update({
        'replies': FieldValue.increment(1),
      });

      ref
          .read(notificationsControllerProvider)
          .replyToAComment(commenterId, postId, commentId, replyId);
    } catch (e) {
      print(e);
    }
  }

  Future repliesToComment(String commentId) async {
    return firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Replies')
        .where('deleted', isEqualTo: false)
        .get();
  }

  Stream repliestDataSteam(String commentId, String replyId) {
    return firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Replies')
        .doc(replyId)
        .snapshots();
  }

  void deleteReplyToComment(String postId, String commentId, String replyId,
      String commenterId, ProviderRef ref) async {
    try {
      await firestore
          .collection('PostsInteractions')
          .doc(postId)
          .collection('Comments')
          .doc(commentId)
          .update({'replies': FieldValue.increment(-1)});

      await firestore
          .collection('CommentsInteractions')
          .doc(commentId)
          .collection('Replies')
          .doc(replyId)
          .update({
        'deleted': true,
      });

      ref.read(notificationsControllerProvider).unReplyToComment(
            commenterId,
            commentId,
            replyId,
          );
      Get.snackbar('🗑', 'Your Reply Has Been Deleted Successfully',
          backgroundColor: AppColors.green, colorText: AppColors.white);
    } catch (e) {
      print(e);
    }
  }

  void likeAReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
    ProviderRef ref,
  ) async {
    try {
      await firestore
          .collection('RepliesInteractions')
          .doc(replyId)
          .collection('Likes')
          .doc(auth.currentUser!.uid)
          .set({
        'likedAt': DateTime.now(),
        'userId': auth.currentUser!.uid,
      });

      await firestore
          .collection('CommentsInteractions')
          .doc(commentId)
          .collection('Replies')
          .doc(replyId)
          .update({
        'likes': FieldValue.increment(1),
      });

      ref
          .read(notificationsControllerProvider)
          .likedYourReplyToAComment(baseId, postId, commentId, replyId);
    } catch (e) {
      print(e);
    }
  }

  void unLikeAReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
    ProviderRef ref,
  ) async {
    try {
      await firestore
          .collection('RepliesInteractions')
          .doc(replyId)
          .collection('Likes')
          .doc(auth.currentUser!.uid)
          .delete();

      await firestore
          .collection('CommentsInteractions')
          .doc(commentId)
          .collection('Replies')
          .doc(replyId)
          .update({
        'likes': FieldValue.increment(-1),
      });
      ref.read(notificationsControllerProvider).unLikeAReplyToAComment(
            baseId,
            postId,
            commentId,
            replyId,
          );
    } catch (e) {
      print(e);
    }
  }

  void disLikeAReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
    ProviderRef ref,
  ) async {
    try {
      await firestore
          .collection('RepliesInteractions')
          .doc(replyId)
          .collection('DisLikes')
          .doc(auth.currentUser!.uid)
          .set({
        'disLikedAt': DateTime.now(),
        'userId': auth.currentUser!.uid,
      });

      await firestore
          .collection('CommentsInteractions')
          .doc(commentId)
          .collection('Replies')
          .doc(replyId)
          .update({
        'dislikes': FieldValue.increment(1),
      });
      ref
          .read(notificationsControllerProvider)
          .disLikedYourReplyToAComment(baseId, postId, commentId, replyId);
    } catch (e) {
      print(e);
    }
  }

  void unDisLikeAReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
    ProviderRef ref,
  ) async {
    try {
      await firestore
          .collection('RepliesInteractions')
          .doc(replyId)
          .collection('DisLikes')
          .doc(auth.currentUser!.uid)
          .delete();
      await firestore
          .collection('CommentsInteractions')
          .doc(commentId)
          .collection('Replies')
          .doc(replyId)
          .update({
        'dislikes': FieldValue.increment(-1),
      });
      ref
          .read(notificationsControllerProvider)
          .unDisLikeAReplyToAComment(baseId, postId, commentId, replyId);
    } catch (e) {
      print(e);
    }
  }

  Stream repliesToCommentsLikesInteractionsStream(String replyId) {
    return firestore
        .collection('RepliesInteractions')
        .doc(replyId)
        .collection('Likes')
        .snapshots();
  }

  Stream repliesToCommentsDisLikesInteractionsStream(String replyId) {
    return firestore
        .collection('RepliesInteractions')
        .doc(replyId)
        .collection('DisLikes')
        .snapshots();
  }
}
