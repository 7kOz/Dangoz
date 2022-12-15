import 'dart:convert';

import 'package:dangoz/base/enums/message_enums.dart';

class PostModel {
  final String postId;
  final String posterId;
  final String post;
  final String gifUrl;
  final String imageUrl;
  final String videoUrl;
  final DateTime timePosted;

  final bool isSponsered;
  final bool isFlagged;
  final bool deleted;
  final bool isGeneralPost;
  final bool isNewsPost;
  final bool isIdeasPost;
  final bool isSignalPost;
  final bool isMemePost;
  final bool forexGeneralPost;
  final bool cryptoGeneralPost;
  final bool stocksGeneralPost;
  final bool forexNewsPost;
  final bool cryptoNewsPost;
  final bool stocksNewsPost;
  final bool forexIdeasPost;
  final bool cryptoIdeasPost;
  final bool stocksIdeasPost;
  final bool forexSignalsPost;
  final bool cryptoSignalsPost;
  final bool stocksSignalsPost;
  final bool forexMemesPost;
  final bool cryptoMemesPost;
  final bool stocksMemesPost;

  final int likes;
  final int comments;
  final int dislikes;
  final int reposts;

  final bool isRepost;
  final String reposterId;
  final String repostId;

  PostModel({
    required this.postId,
    required this.posterId,
    required this.post,
    required this.gifUrl,
    required this.imageUrl,
    required this.videoUrl,
    required this.timePosted,
    required this.isSponsered,
    required this.isFlagged,
    required this.isGeneralPost,
    required this.isNewsPost,
    required this.isIdeasPost,
    required this.isSignalPost,
    required this.deleted,
    required this.isMemePost,
    required this.forexGeneralPost,
    required this.cryptoGeneralPost,
    required this.stocksGeneralPost,
    required this.forexNewsPost,
    required this.cryptoNewsPost,
    required this.stocksNewsPost,
    required this.forexIdeasPost,
    required this.cryptoIdeasPost,
    required this.stocksIdeasPost,
    required this.forexSignalsPost,
    required this.cryptoSignalsPost,
    required this.stocksSignalsPost,
    required this.forexMemesPost,
    required this.cryptoMemesPost,
    required this.stocksMemesPost,
    required this.likes,
    required this.comments,
    required this.dislikes,
    required this.reposts,
    required this.isRepost,
    required this.repostId,
    required this.reposterId,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'posterId': posterId,
      'post': post,
      'gifUrl': gifUrl,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'timePosted': timePosted.millisecondsSinceEpoch,
      'isSponsered': isSponsered,
      'isFlagged': isFlagged,
      'isGeneralPost': isGeneralPost,
      'deleted': deleted,
      'isNewsPost': isNewsPost,
      'isIdeasPost': isIdeasPost,
      'isSignalPost': isSignalPost,
      'isMemePost': isMemePost,
      'forexGeneralPost': forexGeneralPost,
      'cryptoGeneralPost': cryptoGeneralPost,
      'stocksGeneralPost': stocksGeneralPost,
      'forexNewsPost': forexNewsPost,
      'cryptoNewsPost': cryptoNewsPost,
      'stocksNewsPost': stocksNewsPost,
      'forexIdeasPost': forexIdeasPost,
      'cryptoIdeasPost': cryptoIdeasPost,
      'stocksIdeasPost': stocksIdeasPost,
      'forexSignalsPost': forexSignalsPost,
      'cryptoSignalsPost': cryptoSignalsPost,
      'stocksSignalsPost': stocksSignalsPost,
      'forexMemesPost': forexMemesPost,
      'cryptoMemesPost': cryptoMemesPost,
      'stocksMemesPost': stocksMemesPost,
      'likes': likes,
      'comments': comments,
      'dislikes': dislikes,
      'reposts': reposts,
      'isRepost': isRepost,
      'repostId': repostId,
      'reposterId': reposterId,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] ?? '',
      posterId: map['posterId'] ?? '',
      post: map['post'] ?? '',
      gifUrl: map['gifUrl'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      timePosted: DateTime.fromMillisecondsSinceEpoch(map['timePosted']),
      isSponsered: map['messageId'] ?? false,
      isFlagged: map['isFlagged'] ?? false,
      deleted: map['deleted'] ?? false,
      isGeneralPost: map['repliedMessage'] ?? false,
      isIdeasPost: map['isIdeasPost'] ?? false,
      isNewsPost: map['isNewsPost'] ?? false,
      isSignalPost: map['isSignalPost'] ?? false,
      isMemePost: map['isMemePost'] ?? false,
      forexGeneralPost: map['forexGeneralPost'] ?? false,
      cryptoGeneralPost: map['cryptoGeneralPost'] ?? false,
      stocksGeneralPost: map['stocksGeneralPost'] ?? false,
      forexNewsPost: map['forexNewsPost'] ?? false,
      cryptoNewsPost: map['cryptoNewsPost'] ?? false,
      stocksNewsPost: map['stocksNewsPost'] ?? false,
      forexIdeasPost: map['forexIdeasPost'] ?? false,
      cryptoIdeasPost: map['cryptoIdeasPost'] ?? false,
      stocksIdeasPost: map['stocksIdeasPost'] ?? false,
      forexSignalsPost: map['forexSignalsPost'] ?? false,
      cryptoSignalsPost: map['cryptoSignalsPost'] ?? false,
      stocksSignalsPost: map['stocksSignalsPost'] ?? false,
      forexMemesPost: map['forexMemesPost'] ?? false,
      cryptoMemesPost: map['cryptoMemesPost'] ?? false,
      stocksMemesPost: map['stocksMemesPost'] ?? false,
      likes: map['likes'] ?? 0,
      comments: map['comments'] ?? 0,
      dislikes: map['dislikes'] ?? 0,
      reposts: map['reposts'] ?? 0,
      isRepost: map['isRepost'] ?? false,
      repostId: map['repostId'] ?? false,
      reposterId: map['reposterId'] ?? false,
    );
  }
}
