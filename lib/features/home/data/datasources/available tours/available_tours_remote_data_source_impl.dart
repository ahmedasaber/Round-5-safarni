import 'package:dio/dio.dart';
import 'package:safarni/features/home/data/datasources/available%20tours/available_tours_remote_data_source.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

class AvailableToursRemoteDataSourceImpl
    extends AvailableToursRemoteDataSource {
  final Dio dio;
  final FavoriteLocalDataSource favoriteLocalDataSource;

  AvailableToursRemoteDataSourceImpl({
    required this.favoriteLocalDataSource,
    required this.dio,
  });

  @override
  Future<List<TourModel>> fetchAvailableTours() async {
    try {
      Response response = await dio.get(
        'http://round5-safarnia.huma-volve.com/api/available-tours',
      );
      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        List<TourModel> toursList = data
            .map((availableTour) => TourModel.fromJson(availableTour))
            .toList();

        final Set favIds = favoriteLocalDataSource.favIds;
        for (var tour in toursList) {
          if (favIds.contains(tour.id)) {
            tour.isFav = true;
          }
        }
        return toursList;
      } else {
        throw Exception('Failed to load the Available Tours');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Response Failed: $e');
    }
  }
}
