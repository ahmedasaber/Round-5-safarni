import 'package:safarni/features/internal_tour/data/models/tours.dart';
// part of 'tour_cubit.dart';



abstract class TourState {}

class TourInitial extends TourState {}



class TourLoading extends TourState {}

class TourSuccess extends TourState {
  final List<Tour> tours;
  TourSuccess(this.tours);
}

class TourFailure extends TourState {

  final String error;
  TourFailure(this.error);
}