import '../entities/destination.dart';

abstract class DestinationRepository {
  Future<Destination> getDestinationDetails(String id);
}
