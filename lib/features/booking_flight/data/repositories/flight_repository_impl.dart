import '../../domain/entities/flight_entity.dart';
import '../../domain/repositories/flight_repository.dart';
import '../datasource/flight_remote_datasource.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<FlightEntity>> searchFlights({
    required String from,
    required String to,
    required String departureDate,
    required String returnDate,
    required String tripType,
    required int passengers,
  }) {
    return remoteDataSource.searchFlights(
      from,
      to,
      departureDate,
      returnDate,
      tripType,
      passengers,
    );
  }
}
