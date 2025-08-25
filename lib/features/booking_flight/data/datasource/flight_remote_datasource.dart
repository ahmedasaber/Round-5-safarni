// lib/features/booking_flight/data/datasources/flight_remote_data_source.dart
import 'package:dio/dio.dart';
import '../models/flight_model.dart';

abstract class FlightRemoteDataSource {
  Future<List<FlightModel>> searchFlights(
      String from,
      String to,
      String departureDate,
      String returnDate,
      String tripType,
      int passengers,
      );
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  final Dio dio;

  FlightRemoteDataSourceImpl(this.dio);

  @override
  Future<List<FlightModel>> searchFlights(
      String from,
      String to,
      String departureDate,
      String returnDate,
      String tripType,
      int passengers,
      ) async {
    try {
      final response = await dio.get(
        "http://round5-safarnia.huma-volve.com/api/flights",
        queryParameters: {
          "from": from,
          "to": to,
          "departure_date": departureDate,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          return data.map((e) => FlightModel.fromJson(e)).toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load flights (code: ${response.statusCode})");
      }
    } on DioError catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
