import '../entities/destination.dart';
import '../repositories/destination_repository.dart';

class GetDestinationDetails {
  final DestinationRepository repository;

  GetDestinationDetails(this.repository);

  Future<Destination> call(String id) async {
    return await repository.getDestinationDetails(id);
  }
}
