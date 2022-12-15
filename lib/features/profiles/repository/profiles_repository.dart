import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final profilesRepositoryProvider = Provider(
  (ref) => ProfilesRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ProfilesRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ProfilesRepository({
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

  Stream followingStream() {
    return firestore
        .collection('FF')
        .doc(auth.currentUser!.uid)
        .collection('Following')
        .snapshots();
  }

  Stream followersStream() {
    return firestore
        .collection('FF')
        .doc(auth.currentUser!.uid)
        .collection('Followers')
        .snapshots();
  }

  Stream notificationsStream(String baseId) {
    return firestore
        .collection('Notifications')
        .doc(baseId)
        .collection('SpecificNotifications')
        .snapshots();
  }

  Future allPosts(String profileId) async {
    var allPosts = await firestore
        .collection('Posts')
        .orderBy('timePosted', descending: true)
        .where('posterId', isEqualTo: profileId)
        .get();

    return allPosts;
  }

  //Add Notifications
  void followPrivateUser(String baseId) async {
    String notificationId = Uuid().v1();
    try {
      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .set({
        'type': 'friendRequest',
        'notificationId': notificationId,
        'sentAt': DateTime.now(),
        'userUid': auth.currentUser!.uid,
        'title': 'Friend Request',
        'message': '',
      });
      await firestore.collection('NotifiBool').doc(baseId).update({
        'newNotif': true,
      });
    } catch (e) {
      print(e);
    }
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

  void cancelFriendRequest(String baseId, String notificationId) async {
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

  void followUser(String baseId) async {
    String notificationId = Uuid().v1();
    try {
      await firestore
          .collection('FF')
          .doc(baseId)
          .collection('Followers')
          .doc(auth.currentUser!.uid)
          .set({
        'uid': auth.currentUser!.uid,
        'followedAt': DateTime.now(),
      });
      await firestore
          .collection('FF')
          .doc(auth.currentUser!.uid)
          .collection('Following')
          .doc(baseId)
          .set({
        'uid': baseId,
        'followedAt': DateTime.now(),
      });
      await firestore.collection('Users').doc(baseId).update({
        'followers': FieldValue.increment(1),
      });
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'following': FieldValue.increment(1),
      });
      await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .doc(notificationId)
          .set({
        'type': 'startedFollowing',
        'notificationId': notificationId,
        'sentAt': DateTime.now(),
        'userUid': auth.currentUser!.uid,
        'title': 'Started Following You',
        'message': '',
      });
      await firestore.collection('NotifiBool').doc(baseId).update({
        'newNotif': true,
      });
    } catch (e) {
      print(e);
    }
  }

  void unFollowUser(String baseId) async {
    try {
      await firestore
          .collection('FF')
          .doc(baseId)
          .collection('Followers')
          .doc(auth.currentUser!.uid)
          .delete();
      await firestore
          .collection('FF')
          .doc(auth.currentUser!.uid)
          .collection('Following')
          .doc(baseId)
          .delete();
      await firestore.collection('Users').doc(baseId).update({
        'followers': FieldValue.increment(-1),
      });
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'following': FieldValue.increment(-1),
      });
      QuerySnapshot<Map<String, dynamic>> notificationRef = await firestore
          .collection('Notifications')
          .doc(baseId)
          .collection('SpecificNotifications')
          .where('type', isEqualTo: 'startedFollowing')
          .where('userUid', isEqualTo: auth.currentUser!.uid)
          .get();

      QuerySnapshot<Map<String, dynamic>> notificationRef1 = await firestore
          .collection('Notifications')
          .doc(auth.currentUser!.uid)
          .collection('SpecificNotifications')
          .where('type', isEqualTo: 'acceptedRequest')
          .where('userUid', isEqualTo: baseId)
          .get();

      if (notificationRef.docs.isNotEmpty) {
        String notificationId = notificationRef.docs[0]['notificationId'];
        await firestore
            .collection('Notifications')
            .doc(baseId)
            .collection('SpecificNotifications')
            .doc(notificationId)
            .delete();
      }

      if (notificationRef1.docs.isNotEmpty) {
        String notificationId = notificationRef1.docs[0]['notificationId'];
        await firestore
            .collection('Notifications')
            .doc(auth.currentUser!.uid)
            .collection('SpecificNotifications')
            .doc(notificationId)
            .delete();
      }
    } catch (e) {
      print(e);
    }
  }
}
