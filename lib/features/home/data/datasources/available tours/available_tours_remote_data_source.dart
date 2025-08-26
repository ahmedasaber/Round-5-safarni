import 'package:safarni/features/home/data/models/available_tours_model.dart';

abstract class AvailableToursRemoteDataSource{
  Future<List<TourModel>> fetchAvailableTours();
}
