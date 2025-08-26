import 'package:safarni/features/booking_flight/domain/entities/seat_entity.dart';

abstract class SeatRepository {
  Future<List<SeatEntity>> getSeats(String flightId);
}
// seat