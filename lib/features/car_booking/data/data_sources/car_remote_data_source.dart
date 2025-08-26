import '../models/car.dart';
import 'package:dio/dio.dart';

abstract class CarRemoteDataSource {
  Future<List<Car>> getCars();
  Future<Car> getCarById(int id);
  Future<bool> bookCar(int carId, int userId, String startDate, String endDate);
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://round5-safarnia.huma-volve.com/api";

  CarRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Car>> getCars() async {
    final response = await dio.get("$baseUrl/cars");
    return (response.data as List).map((e) => Car.fromJson(e)).toList();
  }

  @override
  Future<Car> getCarById(int id) async {
    final response = await dio.get("$baseUrl/cars/$id");
    return Car.fromJson(response.data);
  }

  @override
  Future<bool> bookCar(int carId, int userId, String startDate, String endDate) async {
    final response = await dio.post(
      "$baseUrl/bookings",
      data: {
        "car_id": carId,
        "user_id": userId,
        "start_date": startDate,
        "end_date": endDate,
      },
    );
    return response.statusCode == 201;
  }
}
