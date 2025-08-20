import 'package:safarni/features/hotel/data/models/room_model.dart';

class RoomsResponseModel {
  final String status;
  final String message;
  final List<RoomModel> data;

  RoomsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoomsResponseModel.fromJson(Map<String, dynamic> json) {
    return RoomsResponseModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => RoomModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}