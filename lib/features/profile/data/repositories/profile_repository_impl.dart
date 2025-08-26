import 'package:safarni/features/profile/data/datasourc/profile_remote_data_source.dart';

import '../../domain/entities/profile_user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<ProfileUserEntity> getUserProfile() async {
    try {
      final model = await _remoteDataSource.getUserProfile();
      return _modelToEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileUserEntity> updateUserProfile({
    required String name,
    required String email,
    String? phone,
    String? country,
  }) async {
    try {
      final request = ProfileUpdateRequest(
        name: name,
        email: email,
        phone: phone,
        country: country,
      );
      final model = await _remoteDataSource.updateUserProfile(request);
      return _modelToEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _remoteDataSource.deleteAccount();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  ProfileUserEntity _modelToEntity(ProfileUserModel model) {
    return ProfileUserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      phone: model.phone,
      country: model.country,
      image: model.image,
      emailVerifiedAt: model.emailVerifiedAt,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      stats: model.stats != null
          ? ProfileStatsEntity(
              totalBookings: model.stats!.totalBookings,
              totalReviews: model.stats!.totalReviews,
              memberSince: model.stats!.memberSince,
            )
          : null,
    );
  }
}