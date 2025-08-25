import 'package:dio/dio.dart';
import '../models/seat_model.dart';

abstract class SeatRemoteDataSource {
  Future<List<SeatModel>> getSeats(String flightId);
}

class SeatRemoteDataSourceImpl implements SeatRemoteDataSource {
  final Dio dio;

  SeatRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SeatModel>> getSeats(String flightId) async {
    try {
      final response = await dio.get(
        "http://round5-safarnia.huma-volve.com/api/update/flight",
        queryParameters: {"flight_id": flightId},
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((e) => SeatModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load seats: $e");
    }
  }
}
