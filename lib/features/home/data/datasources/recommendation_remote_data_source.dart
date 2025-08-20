import 'package:safarni/features/home/data/models/recommendation_model.dart';

abstract class RecommendationRemoteDataSource{
  Future<List<RecommendationModel>> fetchRecommended();
}