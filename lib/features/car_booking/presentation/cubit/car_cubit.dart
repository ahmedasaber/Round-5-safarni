import 'car_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/car_booking/data/repositories/car_repo.dart';

class CarBookingCubit extends Cubit<CarBookingState> {
  final CarRepository repository;

  CarBookingCubit(this.repository) : super(CarBookingInitial());

  Future<void> loadCars() async {
    emit(CarBookingLoading());
    try {
      final cars = await repository.getCars();
      emit(CarsBookingLoaded(cars));
    } catch (e) {
      emit(CarBookingError(e.toString()));
    }
  }

  Future<void> getCarById(int id) async {
    try {
      emit(CarBookingLoading());
      final car = await repository.getCarById(id);
      emit(CarDetailsLoaded(car)); // ✅
    } catch (e) {
      emit(CarBookingError(e.toString()));
    }
  }

  Future<void> bookCar(
    int carId,
    int userId,
    String startDate,
    String endDate,
  ) async {
    emit(CarBookingLoading());
    try {
      final success = await repository.bookCar(
        carId,
        userId,
        startDate,
        endDate,
      );
      emit(CarBookingBooked(success));
    } catch (e) {
      emit(CarBookingError(e.toString()));
    }
  }
}
