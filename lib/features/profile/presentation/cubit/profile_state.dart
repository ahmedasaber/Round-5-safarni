part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileUserEntity user;

  const ProfileLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;
  final ProfileUserEntity user;

  const ProfileUpdateSuccess({
    required this.message,
    required this.user,
  });

  @override
  List<Object> get props => [message, user];
}

class ProfileImageUploading extends ProfileState {}

class ProfileImageUploadSuccess extends ProfileState {
  final String imageUrl;

  const ProfileImageUploadSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class ProfilePasswordChangeSuccess extends ProfileState {
  final String message;

  const ProfilePasswordChangeSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileAccountDeleted extends ProfileState {
  final String message;

  const ProfileAccountDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileLogoutSuccess extends ProfileState {
  final String message;

  const ProfileLogoutSuccess({required this.message});

  @override
  List<Object> get props => [message];
}