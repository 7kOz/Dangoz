import 'dart:convert';

import 'package:dangoz/base/enums/message_enums.dart';

class CommentModel {
  final String commentId;
  final String userId;
  final String comment;
  final String gifUrl;
  final String imageUrl;

  final DateTime commentedAt;

  final int dislikes;
  final int likes;

  final int replies;
  final String postId;

  CommentModel({
    required this.postId,
    required this.gifUrl,
    required this.imageUrl,
    required this.likes,
    required this.comment,
    required this.dislikes,
    required this.commentedAt,
    required this.commentId,
    required this.replies,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'commentId': commentId,
      'userId': userId,
      'comment': comment,
      'gifUrl': gifUrl,
      'imageUrl': imageUrl,
      'commentedAt': commentedAt.millisecondsSinceEpoch,
      'likes': likes,
      'dislikes': dislikes,
      'replies': replies,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      postId: map['postId'] ?? '',
      commentId: map['commentId'] ?? '',
      comment: map['comment'] ?? '',
      gifUrl: map['gifUrl'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      commentedAt: DateTime.fromMillisecondsSinceEpoch(map['commentedAt']),
      likes: map['likes'] ?? 0,
      dislikes: map['dislikes'] ?? 0,
      replies: map['replies'] ?? 0,
      userId: map['userId'] ?? '',
    );
  }
}
