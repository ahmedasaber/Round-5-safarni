import '../../domain/entities/boarding_pass_entity.dart';
import '../../domain/entities/flight_entity.dart';
import '../../domain/entities/seat_entity.dart';
// presentation/cubit/boarding_pass_state.dart

abstract class FlightBookingState {}

class FlightBookingInitial extends FlightBookingState {}

class FlightBookingLoading extends FlightBookingState {}

class FlightBookingLoaded extends FlightBookingState {
  final List<FlightEntity> flights;
  FlightBookingLoaded(this.flights);
}

class FlightBookingError extends FlightBookingState {
  final String message;
  FlightBookingError(this.message);
}



abstract class SeatState {
  const SeatState();
}

class SeatInitial extends SeatState {}

class SeatLoading extends SeatState {}

class SeatLoaded extends SeatState {
  final List<SeatEntity> seats;

  const SeatLoaded(this.seats);
}

class SeatError extends SeatState {
  final String message;

  const SeatError(this.message);
}


abstract class BoardingPassState {}

class BoardingPassInitial extends BoardingPassState {}

class BoardingPassLoading extends BoardingPassState {}

class BoardingPassLoaded extends BoardingPassState {
  final BoardingPass boardingPass;

  BoardingPassLoaded(this.boardingPass);
}

class BoardingPassError extends BoardingPassState {
  final String message;

  BoardingPassError(this.message);
}
