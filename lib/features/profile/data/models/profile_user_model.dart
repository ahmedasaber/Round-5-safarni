class ProfileUserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? country;
  final String? image;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final ProfileStats? stats;

  const ProfileUserModel({
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

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      country: json['country'],
      image: json['image'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      stats: json['stats'] != null ? ProfileStats.fromJson(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'image': image,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'stats': stats?.toJson(),
    };
  }

  ProfileUserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? country,
    String? image,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    ProfileStats? stats,
  }) {
    return ProfileUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      image: image ?? this.image,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      stats: stats ?? this.stats,
    );
  }
}

class ProfileStats {
  final int totalBookings;
  final int totalReviews;
  final String memberSince;

  const ProfileStats({
    required this.totalBookings,
    required this.totalReviews,
    required this.memberSince,
  });

  factory ProfileStats.fromJson(Map<String, dynamic> json) {
    return ProfileStats(
      totalBookings: json['total_bookings'] ?? 0,
      totalReviews: json['total_reviews'] ?? 0,
      memberSince: json['member_since'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_bookings': totalBookings,
      'total_reviews': totalReviews,
      'member_since': memberSince,
    };
  }
}

class ProfileUpdateRequest {
  final String name;
  final String email;
  final String? phone;
  final String? country;

  const ProfileUpdateRequest({
    required this.name,
    required this.email,
    this.phone,
    this.country,
  });

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateRequest(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
    };
  }
}

class ProfileResponse {
  final bool status;
  final String message;
  final ProfileUserModel? data;

  const ProfileResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ProfileUserModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}