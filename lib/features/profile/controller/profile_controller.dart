import 'package:dangoz/features/profile/repository/profile_repository.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileControllerProvider = Provider((ref) {
  final profilesRepository = ref.watch(profileRepositoryProvider);
  return ProfileController(
    ref: ref,
    profilesRepository: profilesRepository,
  );
});

class ProfileController {
  final ProviderRef ref;
  final ProfileRepository profilesRepository;
  ProfileController({
    required this.ref,
    required this.profilesRepository,
  });

  Stream<UserModel> userDataById(String userUid) {
    return profilesRepository.userData(userUid);
  }

  Stream followersStream() {
    return profilesRepository.followersStream();
  }

  Stream followingStream() {
    return profilesRepository.followingStream();
  }

  void switchAccounToPrivate() {
    profilesRepository.switchAccountToPrivate();
  }

  void switchAccountToPublic() {
    profilesRepository.switchAccountToPublic();
  }

  void removeFollower(String followerId) {
    profilesRepository.removeFollower(followerId);
  }

  void unfollowUser(String followingId) {
    profilesRepository.unfollowUser(followingId);
  }
}
