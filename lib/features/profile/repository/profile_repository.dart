import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ProfileRepository({
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

  Stream followersStream() {
    return firestore
        .collection('FF')
        .doc(auth.currentUser!.uid)
        .collection('Followers')
        .orderBy('followedAt', descending: true)
        .snapshots();
  }

  Stream followingStream() {
    return firestore
        .collection('FF')
        .doc(auth.currentUser!.uid)
        .collection('Following')
        .orderBy('followedAt', descending: true)
        .snapshots();
  }

  void switchAccountToPrivate() async {
    try {
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'isPrivate': true,
      });
    } catch (e) {
      print(e);
    }
  }

  void switchAccountToPublic() async {
    try {
      await firestore.collection('Users').doc(auth.currentUser!.uid).update({
        'isPrivate': false,
      });
    } catch (e) {
      print(e);
    }
  }

  void removeFollower(String followerId) async {
    try {
      await firestore
          .collection('FF')
          .doc(auth.currentUser!.uid)
          .collection('Followers')
          .doc(followerId)
          .delete();

      await firestore
          .collection('FF')
          .doc(followerId)
          .collection('Following')
          .doc(auth.currentUser!.uid)
          .delete();

      QuerySnapshot<Map<String, dynamic>> notificationDocPublic =
          await firestore
              .collection('Notifications')
              .doc(auth.currentUser!.uid)
              .collection('SpecificNotifications')
              .where('type', isEqualTo: 'startedFollowing')
              .where('userUid', isEqualTo: followerId)
              .get();

      if (notificationDocPublic.docs.isNotEmpty) {
        String notificatioIdPublic =
            notificationDocPublic.docs[0]['notificationId'];

        await firestore
            .collection('Notifications')
            .doc(auth.currentUser!.uid)
            .collection('SpecificNotifications')
            .doc(notificatioIdPublic)
            .delete();
      }

      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .update({'followers': FieldValue.increment(-1)});

      await firestore
          .collection('Users')
          .doc(followerId)
          .update({'following': FieldValue.increment(-1)});
    } catch (e) {
      print(e);
    }
  }

  void unfollowUser(String followingId) async {
    try {
      await firestore
          .collection('FF')
          .doc(auth.currentUser!.uid)
          .collection('Following')
          .doc(followingId)
          .delete();

      await firestore
          .collection('FF')
          .doc(followingId)
          .collection('Followers')
          .doc(auth.currentUser!.uid)
          .delete();

      QuerySnapshot<Map<String, dynamic>> notificationDocPublic =
          await firestore
              .collection('Notifications')
              .doc(followingId)
              .collection('SpecificNotifications')
              .where('type', isEqualTo: 'startedFollowing')
              .where('userUid', isEqualTo: auth.currentUser!.uid)
              .get();

      if (notificationDocPublic.docs.isNotEmpty) {
        String notificatioIdPublic =
            notificationDocPublic.docs[0]['notificationId'];

        await firestore
            .collection('Notifications')
            .doc(followingId)
            .collection('SpecificNotifications')
            .doc(notificatioIdPublic)
            .delete();
      }

      QuerySnapshot<Map<String, dynamic>> notificationRef1 = await firestore
          .collection('Notifications')
          .doc(auth.currentUser!.uid)
          .collection('SpecificNotifications')
          .where('type', isEqualTo: 'acceptedRequest')
          .where('userUid', isEqualTo: followingId)
          .get();

      if (notificationRef1.docs.isNotEmpty) {
        String notificationId = notificationRef1.docs[0]['notificationId'];
        await firestore
            .collection('Notifications')
            .doc(auth.currentUser!.uid)
            .collection('SpecificNotifications')
            .doc(notificationId)
            .delete();
      }

      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .update({'following': FieldValue.increment(-1)});

      await firestore
          .collection('Users')
          .doc(followingId)
          .update({'followers': FieldValue.increment(-1)});
    } catch (e) {
      print(e);
    }
  }
}
