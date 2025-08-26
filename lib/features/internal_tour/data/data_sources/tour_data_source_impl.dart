import 'package:dio/dio.dart';
import 'package:safarni/features/internal_tour/data/models/tours.dart';
import 'package:safarni/features/internal_tour/data/data_sources/tour_data_source.dart';

class TourRemoteDataSourceImpl implements TourRemoteDataSource {
  final Dio dio;

  TourRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Tour>> fetchTours() async {
    final response = await dio.get(
      "https://round5-safarnia.huma-volve.com/api/tours",
    );

    if (response.statusCode == 200) {
      final List data = response.data['data'] as List;
      return data.map((json) => Tour.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load tours");
    }
  }
}
