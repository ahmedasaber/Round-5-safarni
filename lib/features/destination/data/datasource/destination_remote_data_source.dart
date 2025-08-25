import 'package:dio/dio.dart';
import '../models/destination_model.dart';

abstract class DestinationRemoteDataSource {
  Future<DestinationModel> getDestinationDetails(String id);
}

class DestinationRemoteDataSourceImpl implements DestinationRemoteDataSource {
  final Dio dio;

  DestinationRemoteDataSourceImpl(this.dio);

  @override
  Future<DestinationModel> getDestinationDetails(String id) async {
    try {
      final response = await dio.get('http://round5-safarnia.huma-volve.com/api/tours/$id');

      if (response.statusCode == 200) {
        return DestinationModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load destination details");
      }
    } catch (e) {
      throw Exception("Error fetching destination details: $e");
    }
  }
}
