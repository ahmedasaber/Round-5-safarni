// data/datasources/boarding_pass_remote_datasource.dart
import 'package:dio/dio.dart';
import '../models/boarding_pass_model.dart';

abstract class BoardingPassRemoteDataSource {
  Future<BoardingPassModel> getBoardingPass();
}

class BoardingPassRemoteDataSourceImpl implements BoardingPassRemoteDataSource {
  final Dio dio;

  BoardingPassRemoteDataSourceImpl(this.dio);

  @override
  Future<BoardingPassModel> getBoardingPass() async {
    final response = await dio.get('http://round5-safarnia.huma-volve.com/api/flight');
    if (response.statusCode == 200) {
      return BoardingPassModel.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch boarding pass');
    }
  }
}
