import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';

abstract class HotelState {}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelSearchLoading extends HotelState {}

class HotelSuccess extends HotelState {
  final List<HotelModel> hotels;
  final List<HotelModel> nearbyHotels;
  final List<HotelModel> recommendedHotels;
  final List<RoomModel> availableRooms;
  final List<HotelModel>? searchResults;
  final String? searchQuery;
  final bool isSearchMode;

  HotelSuccess({
    required this.hotels,
    required this.nearbyHotels,
    required this.recommendedHotels,
    required this.availableRooms,
    this.searchResults,
    this.searchQuery,
    this.isSearchMode = false,
  });
}

class HotelSearchSuccess extends HotelState {
  final List<HotelModel> searchResults;
  final String searchQuery;

  HotelSearchSuccess({required this.searchResults, required this.searchQuery});
}

class HotelError extends HotelState {
  final String message;

  HotelError({ required this.message,});
}
