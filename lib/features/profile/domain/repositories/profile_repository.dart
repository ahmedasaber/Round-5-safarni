import '../entities/profile_user_entity.dart';

abstract class ProfileRepository {
  Future<ProfileUserEntity> getUserProfile();
  Future<ProfileUserEntity> updateUserProfile({
    required String name,
    required String email,
    String? phone,
    String? country,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<void> deleteAccount();
  Future<void> logout();
}
