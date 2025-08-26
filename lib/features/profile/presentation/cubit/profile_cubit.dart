import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safarni/core/helpers/token_manger.dart';
import '../../domain/entities/profile_user_entity.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit({required ProfileRepository repository})
    : _repository = repository,
      super(ProfileInitial());

  Future<void> getUserProfile() async {
    if (isClosed) return;

    emit(ProfileLoading());
    try {
      final user = await _repository.getUserProfile();
      if (!isClosed) {
        emit(ProfileLoaded(user: user));
      }
    } catch (e) {
      if (!isClosed) {
        emit(ProfileError(message: _extractErrorMessage(e)));
      }
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    String? phone,
    String? country,
  }) async {
    if (isClosed) return;

    final currentState = state;
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

      if (!isClosed) {
        emit(ProfileLoaded(user: updatedUser));
        await Future.delayed(const Duration(milliseconds: 100));
        if (!isClosed) {
          emit(
            ProfileUpdateSuccess(
              message: 'Profile updated successfully',
              user: updatedUser,
            ),
          );
        }
      }
    } catch (e) {
      if (!isClosed) {
        if (currentUser != null) {
          emit(ProfileLoaded(user: currentUser));
        }
        emit(ProfileError(message: _extractErrorMessage(e)));
      }
    }
  }

  Future<void> deleteAccount() async {
    if (isClosed) return;

    emit(ProfileLoading());
    try {
      await _repository.deleteAccount();

      // تنظيف التوكن
      await TokenManager.clearTokens();

      if (!isClosed) {
        emit(ProfileAccountDeleted(message: 'Account deleted successfully'));
      }
    } catch (e) {
      // تنظيف التوكن حتى لو فشل الـ API
      await TokenManager.clearTokens();

      if (!isClosed) {
        // في حالة حذف الحساب، نعتبر العملية نجحت محلياً
        emit(ProfileAccountDeleted(message: 'Account deleted successfully'));
      }
    }
  }

  Future<void> logout() async {
    if (isClosed) return;

    emit(ProfileLoading());
    try {
      // تنظيف التوكن أولاً
      await TokenManager.clearTokens();

      // ثم استدعاء الـ API
      await _repository.logout();

      if (!isClosed) {
        emit(ProfileLogoutSuccess(message: 'Logout Successfully'));
      }
    } catch (e) {
      // حتى لو فشل الـ API، نعتبر الخروج نجح محلياً
      await TokenManager.clearTokens();

      if (!isClosed) {
        emit(ProfileLogoutSuccess(message: 'Logout Successfully'));
      }
    }
  }

  String _extractErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return error.toString();
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
