import '../../domain/entities/destination.dart';
import '../../domain/repositories/destination_repository.dart';
import '../datasource/destination_remote_data_source.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final DestinationRemoteDataSource remoteDataSource;

  DestinationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Destination> getDestinationDetails(String id) async {
    return await remoteDataSource.getDestinationDetails(id);
  }
}
