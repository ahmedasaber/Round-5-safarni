import 'package:safarni/features/hotel/data/models/room_model.dart';

class RoomsResponseModel {
  final int status; 
  final String message;
  final List<RoomModel> data;

  RoomsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoomsResponseModel.fromJson(Map<String, dynamic> json) {
    return RoomsResponseModel(
      status: json['status'] is String
          ? int.tryParse(json['status']) ?? 0
          : json['status'] ?? 0,
      message: json['message']?.toString() ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => RoomModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
