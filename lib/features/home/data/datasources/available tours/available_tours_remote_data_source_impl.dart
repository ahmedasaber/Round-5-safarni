import 'package:dio/dio.dart';
import 'package:safarni/features/home/data/datasources/available%20tours/available_tours_remote_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

class AvailableToursRemoteDataSourceImpl extends AvailableToursRemoteDataSource{
  final Dio dio;

  AvailableToursRemoteDataSourceImpl({required this.dio});
  @override
  Future<List<TourModel>> fetchAvailableTours() async{
    try {
      Response response = await dio.get('http://round5-safarnia.huma-volve.com/api/available-tours');
      if(response.statusCode == 200){
        final List data = response.data['data'];
        return data.map((availableTour)=> TourModel.fromJson(availableTour)).toList();
      }else{
        throw Exception('Failed to load the Available Tours');
      }
    } on Exception catch (e) {
      throw Exception('Response Failed');
    }
  }

}