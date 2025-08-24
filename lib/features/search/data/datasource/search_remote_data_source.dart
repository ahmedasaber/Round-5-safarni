import 'package:safarni/features/home/data/models/available_tours_model.dart';

abstract class SearchRemoteDataSource{
  Future<List<TourModel>> fetchSearchedTours(String query);
}