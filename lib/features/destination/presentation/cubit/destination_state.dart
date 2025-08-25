part of 'destination_cubit.dart';

abstract class DestinationState {
  const DestinationState();
}

class DestinationInitial extends DestinationState {}

class DestinationLoading extends DestinationState {}

class DestinationLoaded extends DestinationState {
  final Destination destination;

  const DestinationLoaded(this.destination);
}

class DestinationError extends DestinationState {
  final String message;

  const DestinationError(this.message);
}
