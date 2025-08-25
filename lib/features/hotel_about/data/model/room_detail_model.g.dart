// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDetailModel _$RoomDetailModelFromJson(Map<String, dynamic> json) =>
    RoomDetailModel(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
      price: json['price'] as String,
      area: (json['area'] as num).toInt(),
      capacity: (json['capacity'] as num).toInt(),
      bathroomNumber: (json['bathroom_number'] as num).toInt(),
      image: json['image'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
      averageRating: (json['average_rating'] as num).toDouble(),
      totalReviews: (json['total_reviews'] as num).toInt(),
    );

Map<String, dynamic> _$RoomDetailModelToJson(RoomDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'price': instance.price,
      'area': instance.area,
      'capacity': instance.capacity,
      'bathroom_number': instance.bathroomNumber,
      'image': instance.image,
      'discount': instance.discount,
      'average_rating': instance.averageRating,
      'total_reviews': instance.totalReviews,
    };

RoomDetailResponse _$RoomDetailResponseFromJson(Map<String, dynamic> json) =>
    RoomDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: RoomDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomDetailResponseToJson(RoomDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
