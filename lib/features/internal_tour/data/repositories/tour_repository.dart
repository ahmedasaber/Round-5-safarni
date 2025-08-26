import 'package:safarni/features/internal_tour/data/models/tours.dart';
import 'package:safarni/features/internal_tour/data/data_sources/tour_data_source_impl.dart';


class TourRepository {
  final TourRemoteDataSourceImpl dataSource;

  TourRepository(this.dataSource);

  Future<List<Tour>> getAllTours() async {
    return await dataSource.fetchTours();
  }


}