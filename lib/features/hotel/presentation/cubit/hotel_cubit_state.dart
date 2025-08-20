import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';

abstract class HotelState {}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelSuccess extends HotelState {
  final List<HotelModel> hotels;
  final List<HotelModel> nearbyHotels;
  final List<HotelModel> recommendedHotels;
  final List<RoomModel> availableRooms;

  HotelSuccess({
    required this.hotels,
    required this.nearbyHotels,
    required this.recommendedHotels,
    required this.availableRooms,
  });
}

class HotelError extends HotelState {
  final String message;

  HotelError(this.message);
}
