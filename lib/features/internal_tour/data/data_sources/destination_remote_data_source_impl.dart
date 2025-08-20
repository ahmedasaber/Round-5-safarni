import 'package:dio/dio.dart';
import 'package:safarni/features/internal_tour/data/models/destination.dart';
import 'package:safarni/features/internal_tour/data/data_sources/destination_remote_data_source.dart';

class DestinationRemoteDataSourceImpl implements DestinationRemoteDataSource {
  final Dio dio;

  DestinationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Destination>> fetchDestinations() async {
    final response = await dio.get("destinations");

    if (response.statusCode == 200) {
      final List data = response.data as List;
      return data.map((json) => Destination.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load destinations");
    }
  }
}