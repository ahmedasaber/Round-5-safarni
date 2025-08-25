import '../../domain/entities/seat_entity.dart';
import '../../domain/repositories/seat_repository.dart';
import '../datasource/seat_remote_data_source.dart';

class SeatRepositoryImpl implements SeatRepository {
  final SeatRemoteDataSource remoteDataSource;

  SeatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SeatEntity>> getSeats(String flightId) {
    return remoteDataSource.getSeats(flightId);
  }
}
