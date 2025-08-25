import '../../domain/entities/flight_entity.dart';

class FlightModel extends FlightEntity {
  FlightModel({
    required super.id,
    required super.airline,
    required super.from,
    required super.to,
    required super.departureDate,
    required super.returnDate,
    required super.price,
    required super.departureTime,
    required super.arrivalTime,
    required super.duration,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json["id"].toString(),
      airline: json["airline"],
      from: json["from"],
      to: json["to"],
      departureDate: DateTime.parse(json["departure_date"]),
      returnDate: DateTime.parse(json["return_date"]),
      price: double.parse(json["price"].toString()),
      departureTime: json["departure_time"] ?? "",
      arrivalTime: json["arrival_time"] ?? "",
      duration: json["duration"] ?? "",
    );
  }
}
