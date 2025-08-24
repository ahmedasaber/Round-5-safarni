import '../models/car.dart';
import '../data_sources/car_remote_data_source.dart';

abstract class CarRepository {
  Future<List<Car>> getCars();
  Future<Car> getCarById(int id);
  Future<bool> bookCar(int carId, int userId, String startDate, String endDate);
}

class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Car>> getCars() => remoteDataSource.getCars();

  @override
  Future<Car> getCarById(int id) => remoteDataSource.getCarById(id);

  @override
  Future<bool> bookCar(int carId, int userId, String startDate, String endDate) =>
      remoteDataSource.bookCar(carId, userId, startDate, endDate);
}
