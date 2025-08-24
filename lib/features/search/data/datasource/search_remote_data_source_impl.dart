import 'package:dio/dio.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/search/data/datasource/search_remote_data_source.dart';

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource{
  final Dio dio;
  final FavoriteLocalDataSource favoriteLocalDataSource;

  SearchRemoteDataSourceImpl({required this.dio, required this.favoriteLocalDataSource});

  @override
    Future<List<TourModel>> fetchSearchedTours(String query) async{
      try {
        Response response = await dio.get('http://round5-safarnia.huma-volve.com/api/tours?search=$query');
        if(response.statusCode == 200){
          final List data = response.data['data'];
          List<TourModel> toursList = data.map((searchedTour)=> TourModel.fromJson(searchedTour)).toList();
          final Set favIds = favoriteLocalDataSource.favIds;
          for(var tour in toursList){
            if(favIds.contains(tour.id)){
              tour.isFav = true;
            }
          }
          return toursList;
        }else{
          throw Exception('Failed to load the Searched Tours');
        }
      } on Exception catch (e) {
        throw Exception('Response Failed');
      }
    }
  }