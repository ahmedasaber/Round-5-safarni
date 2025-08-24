import 'package:safarni/features/internal_tour/data/models/tours.dart';

abstract class TourRemoteDataSource {
  Future<List<Tour>> fetchTours();
}
