part of 'destination_cubit.dart';


abstract class DestinationState {}

class DestinationInitial extends DestinationState {}

class DestinationLoading extends DestinationState {}

class DestinationSuccess extends DestinationState {
  final List<Destination> destinations;

  DestinationSuccess(this.destinations);
}

class DestinationFailure extends DestinationState {
  final String error;

  DestinationFailure(this.error);
}
