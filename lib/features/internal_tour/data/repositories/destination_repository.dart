import 'package:safarni/features/internal_tour/data/models/destination.dart';
import 'package:safarni/features/internal_tour/data/data_sources/destination_remote_data_source_impl.dart';


class DestinationRepository {
  final DestinationRemoteDataSourceImpl dataSource;

  DestinationRepository(this.dataSource);

  Future<List<Destination>> getAllDestinations() async {
    return await dataSource.fetchDestinations();
  }


}