import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final notificationsRepositoryProvider = Provider(
  (ref) => NotificationsRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class NotificationsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  NotificationsRepository({
    required this.firestore,
    required this.auth,
  });

  Stream notificationsStream() {
    return firestore
        .collection('Notifications')
        .doc(auth.currentUser!.uid)
        .collection('SpecificNotifications')
        .orderBy('sentAt', descending: true)
        .snapshots();
  }

  Future notificationFuture(String notificationId) async {
    return await firestore
        .collection('Notifications')
        .doc(auth.currentUser!.uid)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .get();
  }

  Future postData(String postId) async {
    return firestore.collection('Posts').doc(postId).get();
  }

  Future commentData(String postId, String commentId) async {
    return firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .get();
  }

  Future userDataById(String id) {
    return firestore.collection('Users').doc(id).get();
  }

  void declineFriendRequest(String baseId, String notificationId) async {
    try {
      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  void acceptFriendRequest(String baseId, String notificationId) async {
    try {
      await firestore
          .collection('Notifications')
          .doc(auth.currentUser!.uid)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .delete();
      await firestore
          .collection('FF')
          .doc(baseId)
          .collection('Following')
          .doc(auth.currentUser!.uid)
          .set({
        'uid': auth.currentUser!.uid,
        'followedAt': DateTime.now(),
      });
      await firestore
          .collection('FF')
          .doc(auth.currentUser!.uid)
          .collection('Followers')
          .doc(baseId)
          .set({
        'uid': baseId,
        'followedAt': DateTime.now(),
      });
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'followers': FieldValue.increment(1),
      });
      await firestore.collection('Users').doc(baseId).update({
        'following': FieldValue.increment(1),
      });

      await firestore
          .collection('Notifications')
          .doc(auth.currentUser!.uid)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .set({
        'type': 'startedFollowing',
        'notificationId': notificationId,
        'sentAt': DateTime.now(),
        'userUid': baseId,
        'title': 'Started Following You',
        'message': '',
      });

      String acceptedFriendRequestId = Uuid().v1();

      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(acceptedFriendRequestId)
          .set({
        'type': 'acceptedRequest',
        'notificationId': acceptedFriendRequestId,
        'sentAt': DateTime.now(),
        'userUid': auth.currentUser!.uid,
        'title': 'Accepted Friend Request',
        'message': '',
      });

      await firestore
          .collection('NotifiBool')
          .doc(auth.currentUser!.uid)
          .update({
        'newNotif': true,
      });
    } catch (e) {
      print(e);
    }
  }

  void likedYourPost(String baseId, String postId) async {
    String notificationId = Uuid().v1();

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .set({
      'type': 'likedPost',
      'notificationId': notificationId,
      'sentAt': DateTime.now(),
      'userUid': auth.currentUser!.uid,
      'title': 'Liked Your Post',
      'message': postId,
    });

    await firestore.collection('NotifiBool').doc(baseId).update({
      'newNotif': true,
    });
  }

  void unLikedYourPost(String baseId, String postId) async {
    String notificationId = '';

    var notifiSnap = await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .where('userUid', isEqualTo: auth.currentUser!.uid)
        .where('message', isEqualTo: postId)
        .where('type', isEqualTo: 'likedPost')
        .get();

    notificationId = notifiSnap.docs[0].id;

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .delete();
  }

  void disLikedYourPost(String baseId, String postId) async {
    String notificationId = Uuid().v1();

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .set({
      'type': 'disLikedPost',
      'notificationId': notificationId,
      'sentAt': DateTime.now(),
      'userUid': auth.currentUser!.uid,
      'title': 'Disliked Your Post',
      'message': postId,
    });

    await firestore.collection('NotifiBool').doc(baseId).update({
      'newNotif': true,
    });
  }

  void unDisLikedYourPost(String baseId, String postId) async {
    String notificationId = '';

    var notifiSnap = await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .where('userUid', isEqualTo: auth.currentUser!.uid)
        .where('message', isEqualTo: postId)
        .where('type', isEqualTo: 'disLikedPost')
        .get();

    notificationId = notifiSnap.docs[0].id;

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .delete();
  }

  void commentedOnYourPost(
      String baseId, String postId, String commentId) async {
    String notificationId = Uuid().v1();

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .set({
      'type': 'commentedOnPost',
      'notificationId': notificationId,
      'sentAt': DateTime.now(),
      'userUid': auth.currentUser!.uid,
      'title': commentId,
      'message': postId,
    });

    await firestore.collection('NotifiBool').doc(baseId).update({
      'newNotif': true,
    });
  }

  void unCommentOnYourPost(
      String baseId, String postId, String commentId) async {
    var notifSnap = await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .where('title', isEqualTo: commentId)
        .where('message', isEqualTo: postId)
        .get();

    String notifId = notifSnap.docs[0].id;

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notifId)
        .delete();
  }

  void repostedYourPost(String baseId, String postId) async {
    String notificationId = Uuid().v1();

    await firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .doc(notificationId)
        .set({
      'type': 'repost',
      'notificationId': notificationId,
      'sentAt': DateTime.now(),
      'userUid': auth.currentUser!.uid,
      'title': '',
      'message': postId,
    });

    await firestore.collection('NotifiBool').doc(baseId).update({
      'newNotif': true,
    });
  }

  void replyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) async {
    String notificationId = const Uuid().v1();
    try {
      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .set({
        'type': 'replyToComment',
        'notificationId': notificationId,
        'sentAt': DateTime.now(),
        'userUid': auth.currentUser!.uid,
        'title': replyId,
        'message': commentId,
        'extraMessage': postId,
      });
      await firestore.collection('NotifiBool').doc(baseId).update({
        'newNotif': true,
      });
    } catch (e) {
      print(e);
    }
  }

  void unReplyToComment(
    String baseId,
    String commentId,
    String replyId,
  ) async {
    try {
      var notifSnap = await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .where('type', isEqualTo: 'replyToComment')
          .where('message', isEqualTo: commentId)
          .where('title', isEqualTo: replyId)
          .get();

      String notifId = notifSnap.docs[0].id;

      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notifId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future commentFuture(String postId, String commentId) async {
    return await firestore
        .collection('PostsInteractions')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .get();
  }

  Future replyFuture(String commentId, String replyId) async {
    return await firestore
        .collection('CommentsInteractions')
        .doc(commentId)
        .collection('Replies')
        .doc(replyId)
        .get();
  }

  void likedYourReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) async {
    String notificationId = const Uuid().v1();
    try {
      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .set({
        'type': 'likereplyToComment',
        'notificationId': notificationId,
        'sentAt': DateTime.now(),
        'userUid': auth.currentUser!.uid,
        'title': replyId,
        'message': commentId,
        'extraMessage': postId,
      });
      await firestore.collection('NotifiBool').doc(baseId).update({
        'newNotif': true,
      });
    } catch (e) {
      print(e);
    }
  }

  void unLikedReplyToYourComment(
    String baseId,
    String commentId,
    String replyId,
  ) async {
    try {
      var notifSnap = await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .where('type', isEqualTo: 'likereplyToComment')
          .where('message', isEqualTo: commentId)
          .where('title', isEqualTo: replyId)
          .get();

      String notifId = notifSnap.docs[0].id;

      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notifId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  void disLikedYourReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) async {
    String notificationId = const Uuid().v1();
    try {
      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .set({
        'type': 'dislikereplyToComment',
        'notificationId': notificationId,
        'sentAt': DateTime.now(),
        'userUid': auth.currentUser!.uid,
        'title': replyId,
        'message': commentId,
        'extraMessage': postId,
      });
      await firestore.collection('NotifiBool').doc(baseId).update({
        'newNotif': true,
      });
    } catch (e) {
      print(e);
    }
  }

  void undisLikedReplyToYourComment(
    String baseId,
    String commentId,
    String replyId,
  ) async {
    try {
      var notifSnap = await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .where('type', isEqualTo: 'dislikereplyToComment')
          .where('message', isEqualTo: commentId)
          .where('title', isEqualTo: replyId)
          .get();

      String notifId = notifSnap.docs[0].id;

      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notifId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
