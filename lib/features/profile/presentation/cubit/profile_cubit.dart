import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_user_entity.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit({required ProfileRepository repository})
    : _repository = repository,
      super(ProfileInitial());

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    try {
      final user = await _repository.getUserProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(message: _extractErrorMessage(e)));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    String? phone,
    String? country,
  }) async {
    final currentState = state;

    // احتفظ بالمستخدم الحالي أثناء التحميل
    ProfileUserEntity? currentUser;
    if (currentState is ProfileLoaded) {
      currentUser = currentState.user;
    }

    emit(ProfileLoading());

    try {
      final updatedUser = await _repository.updateUserProfile(
        name: name,
        email: email,
        phone: phone,
        country: country,
      );

      // أولاً emit ProfileLoaded مع البيانات الجديدة
      emit(ProfileLoaded(user: updatedUser));

      // ثم emit ProfileUpdateSuccess للإشعار
      await Future.delayed(const Duration(milliseconds: 100));
      emit(
        ProfileUpdateSuccess(
          message: 'Profile updated successfully',
          user: updatedUser,
        ),
      );
    } catch (e) {
      // في حالة الخطأ، أرجع للمستخدم السابق إن وجد
      if (currentUser != null) {
        emit(ProfileLoaded(user: currentUser));
      }
      emit(ProfileError(message: _extractErrorMessage(e)));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ProfileLoading());
    try {
      await _repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(
        ProfilePasswordChangeSuccess(message: 'Password changed successfully'),
      );
    } catch (e) {
      emit(ProfileError(message: _extractErrorMessage(e)));
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    try {
      await _repository.deleteAccount();
      emit(ProfileAccountDeleted(message: 'Account deleted successfully'));
    } catch (e) {
      emit(ProfileError(message: _extractErrorMessage(e)));
    }
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    try {
      // هنا ممكن تضيف API call للـ logout
      // await _repository.logout();

      // امسح التوكنز
      // await TokenManager.clearTokens();

      emit(ProfileLogoutSuccess(message: 'Logged out successfully'));
    } catch (e) {
      emit(ProfileError(message: _extractErrorMessage(e)));
    }
  }

  String _extractErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return error.toString();
  }
}
