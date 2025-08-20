import 'package:dio/dio.dart';
import 'package:safarni/features/home/data/datasources/recommendation_remote_data_source.dart';
import 'package:safarni/features/home/data/models/recommendation_model.dart';

class RecommendationRemoteDataSourceImpl extends RecommendationRemoteDataSource{
  Dio dio = Dio();
  @override
  Future<List<RecommendationModel>> fetchRecommended() async{
    try {
      Response response = await dio.get('http://round5-safarnia.huma-volve.com/api/recommendedtour');
      if(response.statusCode == 200){
        final List data = response.data['data'];
        return data.map((recommended)=> RecommendationModel.fromJson(recommended)).toList();
      }else{
        throw throw Exception('Failed to load the Recommendations');
      }
    } on Exception catch (e) {
      throw throw Exception('Response Failed');
    }
  }

}