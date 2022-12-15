import 'package:dangoz/features/notifications/repository/notifications_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsControllerProvider = Provider((ref) {
  final notificationsRepository = ref.watch(notificationsRepositoryProvider);
  return NotificationsController(
    ref: ref,
    notificationsRepository: notificationsRepository,
  );
});

class NotificationsController {
  final ProviderRef ref;
  final NotificationsRepository notificationsRepository;
  NotificationsController({
    required this.ref,
    required this.notificationsRepository,
  });

  Stream notificationsStream() {
    return notificationsRepository.notificationsStream();
  }

  Future userDataById(String id) {
    return notificationsRepository.userDataById(id);
  }

  Future notificationFuture(String notificationId) {
    return notificationsRepository.notificationFuture(notificationId);
  }

  Future postData(String postId) {
    return notificationsRepository.postData(postId);
  }

  Future commentData(String postId, String commentId) {
    return notificationsRepository.commentData(postId, commentId);
  }

  void declineFriendRequest(String baseId, String notificationId) {
    notificationsRepository.declineFriendRequest(baseId, notificationId);
  }

  void acceptFriendRequest(String baseId, String notificationId) {
    notificationsRepository.acceptFriendRequest(baseId, notificationId);
  }

  void likedYourPost(String baseId, String postId) {
    notificationsRepository.likedYourPost(baseId, postId);
  }

  void unLikedYourPost(String baseId, String postId) {
    notificationsRepository.unLikedYourPost(baseId, postId);
  }

  void disLikedYourPost(String baseId, String postId) {
    notificationsRepository.disLikedYourPost(baseId, postId);
  }

  void unDisLikedYourPost(String baseId, String postId) {
    notificationsRepository.unDisLikedYourPost(baseId, postId);
  }

  void commentedOnYourPost(String baseId, String postId, String commentId) {
    notificationsRepository.commentedOnYourPost(baseId, postId, commentId);
  }

  void unCommentOnYourPost(String baseId, String postId, String commentId) {
    notificationsRepository.unCommentOnYourPost(baseId, postId, commentId);
  }

  void repostedYourPost(String baseId, String postId) {
    notificationsRepository.repostedYourPost(baseId, postId);
  }

  void replyToAComment(
      String baseId, String postId, String commentId, String replyId) {
    notificationsRepository.replyToAComment(baseId, postId, commentId, replyId);
  }

  void unReplyToComment(String baseId, String commentId, String replyId) {
    notificationsRepository.unReplyToComment(baseId, commentId, replyId);
  }

  Future commentFuture(String postId, String commentId) {
    return notificationsRepository.commentFuture(postId, commentId);
  }

  Future replyFuture(String commentId, String replyId) {
    return notificationsRepository.replyFuture(commentId, replyId);
  }

  void likedYourReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) {
    notificationsRepository.likedYourReplyToAComment(
      baseId,
      postId,
      commentId,
      replyId,
    );
  }

  void unLikeAReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) {
    notificationsRepository.unLikedReplyToYourComment(
        baseId, commentId, replyId);
  }

  void disLikedYourReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) {
    notificationsRepository.disLikedYourReplyToAComment(
      baseId,
      postId,
      commentId,
      replyId,
    );
  }

  void unDisLikeAReplyToAComment(
    String baseId,
    String postId,
    String commentId,
    String replyId,
  ) {
    notificationsRepository.undisLikedReplyToYourComment(
        baseId, commentId, replyId);
  }
}
