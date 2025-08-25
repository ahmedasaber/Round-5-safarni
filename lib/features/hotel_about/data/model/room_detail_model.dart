import 'package:json_annotation/json_annotation.dart';

part 'room_detail_model.g.dart';

@JsonSerializable()
class RoomDetailModel {
  final int id;
  final String description;
  final String price;
  final int area;
  final int capacity;
  @JsonKey(name: 'bathroom_number')
  final int bathroomNumber;
  final String image;
  final double? discount;
  @JsonKey(name: 'average_rating')
  final double averageRating;
  @JsonKey(name: 'total_reviews')
  final int totalReviews;

  RoomDetailModel({
    required this.id,
    required this.description,
    required this.price,
    required this.area,
    required this.capacity,
    required this.bathroomNumber,
    required this.image,
    this.discount,
    required this.averageRating,
    required this.totalReviews,
  });

  factory RoomDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RoomDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDetailModelToJson(this);
}

@JsonSerializable()
class RoomDetailResponse {
  final int status;
  final String message;
  final RoomDetailModel data;

  RoomDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoomDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RoomDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDetailResponseToJson(this);
}