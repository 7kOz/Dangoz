import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String birthday;
  final String name;
  final String userName;
  final String phoneNumber;
  final String location;
  final String? profileImage;
  final bool isVerified;
  final int following;
  final int followers;
  final bool isPro;
  final DateTime joined;
  final String bio;
  final bool isOnline;
  final List<String> groupdId;
  final String deviceLocale;
  final List<String> deviceData;
  final DateTime isProTill;
  final bool autoRenew;
  final bool isPrivate;
  final int generalPosts;
  final int newsPosts;
  final int ideasPosts;
  final int signalPosts;
  final int memePosts;
  final int forexGeneralPosts;
  final int cryptoGeneralPosts;
  final int stocksGeneralPosts;
  final int forexNewsPosts;
  final int cryptoNewsPosts;
  final int stocksNewsPosts;
  final int forexIdeasPosts;
  final int cryptoIdeasPosts;
  final int stocksIdeasPosts;
  final int forexSignalsPosts;
  final int cryptoSignalsPosts;
  final int stocksSignalsPosts;
  final int forexMemesPosts;
  final int cryptoMemesPosts;
  final int stocksMemesPosts;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.birthday,
    required this.userName,
    required this.phoneNumber,
    required this.location,
    required this.profileImage,
    required this.isVerified,
    required this.followers,
    required this.following,
    required this.isPrivate,
    required this.isPro,
    required this.joined,
    required this.bio,
    required this.isOnline,
    required this.groupdId,
    required this.deviceLocale,
    required this.deviceData,
    required this.isProTill,
    required this.autoRenew,
    required this.generalPosts,
    required this.newsPosts,
    required this.ideasPosts,
    required this.signalPosts,
    required this.memePosts,
    required this.forexGeneralPosts,
    required this.cryptoGeneralPosts,
    required this.stocksGeneralPosts,
    required this.forexNewsPosts,
    required this.cryptoNewsPosts,
    required this.stocksNewsPosts,
    required this.forexIdeasPosts,
    required this.cryptoIdeasPosts,
    required this.stocksIdeasPosts,
    required this.forexSignalsPosts,
    required this.cryptoSignalsPosts,
    required this.stocksSignalsPosts,
    required this.forexMemesPosts,
    required this.cryptoMemesPosts,
    required this.stocksMemesPosts,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'birthday': birthday,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'location': location,
      'profileImage': profileImage,
      'isVerified': isVerified,
      'followers': followers,
      'following': following,
      'isPro': isPro,
      'joined': joined,
      'bio': bio,
      'isOnline': isOnline,
      'groupdId': groupdId,
      'deviceLocale': deviceLocale,
      'deviceData': deviceData,
      'isPrivate': isPrivate,
      'isProTill': isProTill,
      'autoRenew': autoRenew,
      'generalPosts': generalPosts,
      'newsPosts': newsPosts,
      'ideasPosts': ideasPosts,
      'signalPosts': signalPosts,
      'memePosts': memePosts,
      'forexGeneralPosts': forexGeneralPosts,
      'cryptoGeneralPosts': cryptoGeneralPosts,
      'stocksGeneralPosts': stocksGeneralPosts,
      'forexNewsPosts': forexNewsPosts,
      'cryptoNewsPosts': cryptoNewsPosts,
      'stocksNewsPosts': stocksNewsPosts,
      'forexIdeasPosts': forexIdeasPosts,
      'cryptoIdeasPosts': cryptoIdeasPosts,
      'stocksIdeasPosts': stocksIdeasPosts,
      'forexSignalsPosts': forexSignalsPosts,
      'cryptoSignalsPosts': cryptoSignalsPosts,
      'stocksSignalsPosts': stocksSignalsPosts,
      'forexMemesPosts': forexMemesPosts,
      'cryptoMemesPosts': cryptoMemesPosts,
      'stocksMemesPosts': stocksMemesPosts,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      birthday: map['birthday'] ?? '',
      userName: map['userName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      location: map['location'] ?? '',
      profileImage: map['profileImage'],
      isPro: map['isPro'] ?? false,
      isVerified: map['isVerified'] ?? false,
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
      joined: (map['joined'] as Timestamp).toDate(),
      bio: map['bio'] ?? '',
      isPrivate: map['isPrivate'] ?? false,
      isOnline: map['isOnline'] ?? false,
      groupdId: List<String>.from(map['groupdId'] ?? []),
      deviceLocale: map['deviceLocale'] ?? '',
      deviceData: List<String>.from(map['deviceData'] ?? []),
      isProTill: (map['isProTill'] as Timestamp).toDate(),
      autoRenew: map['autoRenew'] ?? false,
      generalPosts: map['generalPosts']?.toInt() ?? 0,
      newsPosts: map['newsPosts']?.toInt() ?? 0,
      ideasPosts: map['ideasPosts']?.toInt() ?? 0,
      signalPosts: map['signalPosts']?.toInt() ?? 0,
      memePosts: map['memePosts']?.toInt() ?? 0,
      forexGeneralPosts: map['forexGeneralPosts']?.toInt() ?? 0,
      cryptoGeneralPosts: map['cryptoGeneralPosts']?.toInt() ?? 0,
      stocksGeneralPosts: map['stocksGeneralPosts']?.toInt() ?? 0,
      forexNewsPosts: map['forexNewsPosts']?.toInt() ?? 0,
      cryptoNewsPosts: map['cryptoNewsPosts']?.toInt() ?? 0,
      stocksNewsPosts: map['stocksNewsPosts']?.toInt() ?? 0,
      forexIdeasPosts: map['forexIdeasPosts']?.toInt() ?? 0,
      cryptoIdeasPosts: map['cryptoIdeasPosts']?.toInt() ?? 0,
      stocksIdeasPosts: map['stocksIdeasPosts']?.toInt() ?? 0,
      forexSignalsPosts: map['forexSignalsPosts']?.toInt() ?? 0,
      cryptoSignalsPosts: map['cryptoSignalsPosts']?.toInt() ?? 0,
      stocksSignalsPosts: map['stocksSignalsPosts']?.toInt() ?? 0,
      forexMemesPosts: map['forexMemesPosts']?.toInt() ?? 0,
      cryptoMemesPosts: map['cryptoMemesPosts']?.toInt() ?? 0,
      stocksMemesPosts: map['stocksMemesPosts']?.toInt() ?? 0,
    );
  }
}
