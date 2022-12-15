import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  //Get The List Of Contacts From A Device
  Future<List<String>> getContactsFromPhone() async {
    List<Contact> contacts = [];
    List<String> contactsListFromFireStore = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
        var userCollection = await firestore.collection('Users').get();
        for (var document in userCollection.docs) {
          var userData = UserModel.fromMap(document.data());
          for (int i = 0; i < contacts.length; i++) {
            if (contacts[i].phones[0].number == userData.phoneNumber) {
              contactsListFromFireStore.add(userData.uid);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return contactsListFromFireStore;
  }
}
