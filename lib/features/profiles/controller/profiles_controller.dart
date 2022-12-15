import 'package:dangoz/features/profiles/repository/profiles_repository.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profilesControllerProvider = Provider((ref) {
  final profilesRepository = ref.watch(profilesRepositoryProvider);
  return ProfilesController(
    ref: ref,
    profilesRepository: profilesRepository,
  );
});

class ProfilesController {
  final ProviderRef ref;
  final ProfilesRepository profilesRepository;
  ProfilesController({
    required this.ref,
    required this.profilesRepository,
  });

  Stream<UserModel> userDataById(String userUid) {
    return profilesRepository.userData(userUid);
  }

  Future allPosts(String profileId) {
    var allPosts = profilesRepository.allPosts(profileId);
    return allPosts;
  }

  Stream followingStream() {
    return profilesRepository.followingStream();
  }

  Stream followersStream() {
    return profilesRepository.followersStream();
  }

  Stream notificationsStream(String baseId) {
    return profilesRepository.notificationsStream(baseId);
  }

  void followUser(String baseId) {
    profilesRepository.followUser(baseId);
  }

  void followPrivateUser(String baseId) {
    profilesRepository.followPrivateUser(baseId);
  }

  void declineFriendRequest(String baseId, String notificationId) {
    profilesRepository.declineFriendRequest(baseId, notificationId);
  }

  void cancelFriendRequest(String baseId, String notificationId) {
    profilesRepository.cancelFriendRequest(baseId, notificationId);
  }

  void unFollowUser(String baseId) {
    profilesRepository.unFollowUser(baseId);
  }
}
