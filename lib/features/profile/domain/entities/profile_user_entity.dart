import 'package:equatable/equatable.dart';

class ProfileUserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? country;
  final String? image;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final ProfileStatsEntity? stats;

  const ProfileUserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.country,
    this.image,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.stats,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        country,
        image,
        emailVerifiedAt,
        createdAt,
        updatedAt,
        stats,
      ];
}

class ProfileStatsEntity extends Equatable {
  final int totalBookings;
  final int totalReviews;
  final String memberSince;

  const ProfileStatsEntity({
    required this.totalBookings,
    required this.totalReviews,
    required this.memberSince,
  });

  @override
  List<Object> get props => [totalBookings, totalReviews, memberSince];
}