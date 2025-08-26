import '../models/profile_user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileUserModel> getUserProfile();
  Future<ProfileUserModel> updateUserProfile(ProfileUpdateRequest request);
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<void> deleteAccount();
}