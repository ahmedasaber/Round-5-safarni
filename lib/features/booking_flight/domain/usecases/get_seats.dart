import '../entities/seat_entity.dart';
import '../repositories/seat_repository.dart';

class GetSeats {
  final SeatRepository repository;

  GetSeats(this.repository);

  Future<List<SeatEntity>> call(String flightId) {
    return repository.getSeats(flightId);
  }
}
