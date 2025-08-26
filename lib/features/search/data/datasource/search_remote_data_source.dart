import 'package:safarni/features/home/data/models/available_tours_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<TourModel>> fetchSearchedTours({
    required String query,
    required String location,
    required String minPrice,
    required String maxPrice,
    required String minRate,
    required String sortedBy,
  });
}
