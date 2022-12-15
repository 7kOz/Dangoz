import 'dart:io';

import 'package:dangoz/features/posts/repository/post_repository.dart';
import 'package:dangoz/models/comment_model.dart';
import 'package:dangoz/models/post_model.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postControllerProvider = Provider((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  return PostController(
    ref: ref,
    postRepository: postRepository,
  );
});

class PostController {
  final ProviderRef ref;
  final PostRepository postRepository;
  PostController({
    required this.ref,
    required this.postRepository,
  });

  Stream<UserModel> userDataById(String userUid) {
    return postRepository.userData(userUid);
  }

  Future userDataByIdFuture(String userUid) {
    return postRepository.userDataByIdFuture(userUid);
  }

  Stream<PostModel> postDataById(String postId) {
    return postRepository.postData(postId);
  }

  Stream commentDataById(String postId, String commentId) {
    return postRepository.commentData(postId, commentId);
  }

  Stream postLikesInteractionsStream(String postId) {
    return postRepository.postLikesInteractionsStream(postId);
  }

  Stream postDisLikesInteractionsStream(String postId) {
    return postRepository.postDisLikesInteractionsStream(postId);
  }

  //Comments Section
  Stream commentsLikesInteractionsStream(String commentId) {
    return postRepository.commentsLikesInteractionsStream(commentId);
  }

  Stream commentsDisLikesInteractionsStream(String commentId) {
    return postRepository.commentsDisLikesInteractionsStream(commentId);
  }

  //Posts Section
  void saveGeneralPostToDb(
    String posterId,
    String post,
    String gif,
    File? image,
    File? video,
    bool isGeneralPost,
    bool isNewsPost,
    bool isIdeasPost,
    bool isSignalPost,
    bool isMemePost,
  ) {
    if (isGeneralPost == false &&
        isNewsPost == false &&
        isIdeasPost == false &&
        isSignalPost == false &&
        isMemePost == false) {
      isGeneralPost = true;
    }
    postRepository.saveGeneralPostToDb(
      posterId,
      post,
      gif,
      image,
      video,
      ref,
      isGeneralPost,
      isNewsPost,
      isIdeasPost,
      isSignalPost,
      isMemePost,
    );
  }

  Future generalFeeds() {
    var generalFeeds = postRepository.getGeneralFeeds();
    return generalFeeds;
  }

  Future getPostComments(String postId) {
    var postComments = postRepository.getPostComments(postId);
    return postComments;
  }

  void likeAPost(
    String postId,
    String posterId,
    String userId,
  ) {
    postRepository.likeAPost(postId, posterId, userId, ref);
  }

  void unLikeAPost(
    String postId,
    String posterId,
    String userId,
  ) {
    postRepository.unLikeAPost(postId, posterId, userId, ref);
  }

  void disLikeAPost(
    String postId,
    String posterId,
    String userId,
  ) {
    postRepository.disLikeAPost(postId, posterId, userId, ref);
  }

  void unDisLikeAPost(
    String postId,
    String posterId,
    String userId,
  ) {
    postRepository.unDisLikeAPost(postId, posterId, userId, ref);
  }

  void commentOnAPost(
    String postId,
    String posterId,
    String userId,
    String comment,
    String? gifUrl,
    File? image,
  ) async {
    postRepository.commentOnAPost(
      postId,
      posterId,
      userId,
      comment,
      gifUrl,
      image,
      ref,
    );
  }

  void likeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) {
    postRepository.likeAComment(postId, commentId, commenterId, userId);
  }

  void unLikeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) {
    postRepository.unLikeComment(postId, commentId, commenterId, userId);
  }

  void disLikeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) {
    postRepository.disLikeAComment(postId, commentId, commenterId, userId);
  }

  void unDisLikeAComment(
    String postId,
    String commentId,
    String commenterId,
    String userId,
  ) {
    postRepository.unDisLikeAComment(postId, commentId, commenterId, userId);
  }

  void repostAPost(
    String postId,
    String posterId,
    String userId,
    String post,
    String? gifUrl,
    File? image,
    File? video,
    bool isGeneralPost,
    bool isNewsPost,
    bool isIdeasPost,
    bool isSignalPost,
    bool isMemePost,
  ) {
    postRepository.repostAPost(
      postId,
      posterId,
      userId,
      post,
      gifUrl,
      image,
      video,
      ref,
      isGeneralPost,
      isNewsPost,
      isIdeasPost,
      isSignalPost,
      isMemePost,
    );
  }

  void deletePost(
      String postId, String posterId, String imageUrl, String videoUrl) {
    postRepository.deletePost(postId, posterId, ref, imageUrl, videoUrl);
  }

  void deleteComment(String postId, String commentId) {
    postRepository.deleteComment(postId, commentId, ref);
  }

  void replyOnAComment(
    String postId,
    String commentId,
    String commenterId,
    String reply,
    String? gifUrl,
    File? image,
  ) {
    postRepository.replyOnAComment(
        postId, commentId, commenterId, reply, gifUrl, image, ref);
  }

  Future repliesToComment(String commentId) {
    return postRepository.repliesToComment(commentId);
  }

  Stream repliestDataSteam(
    String commentId,
    String replyId,
  ) {
    return postRepository.repliestDataSteam(commentId, replyId);
  }

  void deleteReplyToComment(
    String postId,
    String commentId,
    String replyId,
    String commenterId,
  ) {
    postRepository.deleteReplyToComment(
      postId,
      commentId,
      replyId,
      commenterId,
      ref,
    );
  }

  Stream repliesToCommentsLikesInteractionsStream(String replyId) {
    return postRepository.repliesToCommentsLikesInteractionsStream(replyId);
  }

  Stream repliesToCommentsDisLikesInteractionsStream(String replyId) {
    return postRepository.repliesToCommentsDisLikesInteractionsStream(replyId);
  }

  void likeAReplyToAComment(
      String baseId, String postId, String commentId, String replyId) {
    postRepository.likeAReplyToAComment(
        baseId, postId, commentId, replyId, ref);
  }

  void unLikeAReplyToAComment(
      String baseId, String postId, String commentId, String replyId) {
    postRepository.unLikeAReplyToAComment(
        baseId, postId, commentId, replyId, ref);
  }

  void disLikeAReplyToAComment(
      String baseId, String postId, String commentId, String replyId) {
    postRepository.disLikeAReplyToAComment(
      baseId,
      postId,
      commentId,
      replyId,
      ref,
    );
  }

  void unDisLikeAReplyToAComment(
      String baseId, String postId, String commentId, String replyId) {
    postRepository.unDisLikeAReplyToAComment(
      baseId,
      postId,
      commentId,
      replyId,
      ref,
    );
  }
}
