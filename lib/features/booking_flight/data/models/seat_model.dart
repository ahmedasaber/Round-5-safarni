import '../../domain/entities/seat_entity.dart';

class SeatModel extends SeatEntity {
  const SeatModel({
    required super.seatNumber,
    required super.isAvailable,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      seatNumber: json['seat_number'],
      isAvailable: json['is_available'],
    );
  }
}
