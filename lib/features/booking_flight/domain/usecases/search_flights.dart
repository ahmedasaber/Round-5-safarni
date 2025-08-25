import '../entities/flight_entity.dart';
import '../repositories/flight_repository.dart';

class SearchFlights {
  final FlightRepository repository;

  SearchFlights(this.repository);

  Future<List<FlightEntity>> call({
    required String from,
    required String to,
    required String departureDate,
    required String returnDate,
    required String tripType,
    required int passengers,
  }) {
    return repository.searchFlights(
      from: from,
      to: to,
      departureDate: departureDate,
      returnDate: returnDate,
      tripType: tripType,
      passengers: passengers,
    );
  }
}
