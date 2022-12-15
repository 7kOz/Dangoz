import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationBellRepositoryProvider = Provider(
  (ref) => NotificationBellRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class NotificationBellRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  NotificationBellRepository({
    required this.firestore,
    required this.auth,
  });

  Stream notificationsBell() {
    return firestore
        .collection('NotifiBool')
        .doc(auth.currentUser!.uid)
        .snapshots();
  }

  void seenNotification() async {
    await firestore.collection('NotifiBool').doc(auth.currentUser!.uid).update({
      'newNotif': false,
    });
  }
}
