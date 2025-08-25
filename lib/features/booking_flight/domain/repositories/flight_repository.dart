import '../entities/flight_entity.dart';

abstract class FlightRepository {
  Future<List<FlightEntity>> searchFlights({
    required String from,
    required String to,
    required String departureDate,
    required String returnDate,
    required String tripType,
    required int passengers,
  });
}
