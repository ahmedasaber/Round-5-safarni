import 'package:safarni/features/internal_tour/data/models/destination.dart';

abstract class DestinationRemoteDataSource {
  Future<List<Destination>> fetchDestinations();
}
