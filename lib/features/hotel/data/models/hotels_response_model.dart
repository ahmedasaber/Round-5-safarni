import 'package:safarni/features/hotel/data/models/hotel_model.dart';

class HotelsResponseModel {
  final String status;
  final String message;
  final List<HotelModel> data;

  HotelsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HotelsResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return HotelsResponseModel(
        status: json['status']?.toString() ?? '',
        message: json['message']?.toString() ?? '',
        data:
            (json['data'] as List<dynamic>?)
                ?.map(
                  (item) => HotelModel.fromJson(item as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );
    } catch (e) {
      throw Exception('Failed to parse HotelsResponseModel: $e');
    }
  }
}
