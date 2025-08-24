import '../../data/models/car.dart';


abstract class CarBookingState {

}

class CarBookingInitial extends CarBookingState {}

class CarBookingLoading extends CarBookingState {}

class CarsBookingLoaded extends CarBookingState {
  final List<Car> cars;
  CarsBookingLoaded(this.cars);


}

class CarBookingLoaded extends CarBookingState {
  final Car car;
  CarBookingLoaded(this.car);


}

class CarBookingBooked extends CarBookingState {
  final bool success;
  CarBookingBooked(this.success);

  
}

class CarBookingError extends CarBookingState {
  final String message;
  CarBookingError(this.message);

  
}
class CarDetailsLoaded extends CarBookingState {
  final Car car;
  CarDetailsLoaded(this.car);
}
