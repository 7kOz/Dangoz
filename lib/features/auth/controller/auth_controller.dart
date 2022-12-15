import 'dart:io';

import 'package:dangoz/features/auth/repository/auth_repository.dart';
import 'package:dangoz/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authContrller = ref.watch(authControllerProvider);
  return authContrller.getCurrentUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getCurrentUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }
  //// Email Sign Up

  void singUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String userName,
    String birthday,
  ) async {
    authRepository.singUpWithEmailAndPassword(
        email, password, name, userName, birthday);
  }

  /// Phone Sign In

  void signInWithPhone(String phoneNumber) {
    authRepository.signInWithPhone(phoneNumber);
  }

  void verifyOtp(String verificationId, String userOTP) {
    authRepository.verifyOtp(
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebaseFromPhoneSignInInit(
    String email,
    String name,
    String userName,
    String birthday,
  ) {
    authRepository.saveUserDataToFirebaseFromPhoneSignInInit(
      email: email,
      name: name,
      userName: userName,
      birthday: birthday,
      ref: ref,
    );
  }

  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }
}
