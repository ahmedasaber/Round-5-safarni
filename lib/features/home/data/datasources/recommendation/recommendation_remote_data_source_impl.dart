import 'package:dio/dio.dart';
import 'package:safarni/features/home/data/datasources/recommendation/recommendation_remote_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

class RecommendationRemoteDataSourceImpl extends RecommendationRemoteDataSource {
  final Dio dio;

  RecommendationRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TourModel>> fetchRecommended() async {
    try {
      Response response = await dio.get('http://round5-safarnia.huma-volve.com/api/recommendedtour');
      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return data.map((recommended) => TourModel.fromJson(recommended)).toList();
      } else {
        throw Exception('Failed to load the Recommendations');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Response Failed: $e');
    }
  }
}