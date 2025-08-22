part of 'available_tours_cubit.dart';

@immutable
sealed class AvailableToursState {}

final class AvailableToursInitial extends AvailableToursState {}
final class AvailableToursLoading extends AvailableToursState {}
final class AvailableToursSuccess extends AvailableToursState {
  final List<ToursEntity> availableTours;

  AvailableToursSuccess({required this.availableTours});
}
final class AvailableOursFailure extends AvailableToursState {
  final String message;

  AvailableOursFailure({required this.message});
}
