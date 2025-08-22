import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';
import 'package:safarni/features/hotel/data/repositories/hotel_repository.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository _repository;

  HotelCubit(this._repository) : super(HotelInitial());

  Future<void> fetchAllHotelsData() async {
    emit(HotelLoading());
    try {
      final futures = await Future.wait([
        _repository.getAllHotels(),
        _repository.getNearbyHotels(),
        _repository.getRecommendedHotels(),
      ]);

      final allHotelsResponse = futures[0];
      final nearbyHotelsResponse = futures[1];
      final recommendedHotelsResponse = futures[2];

      emit(
        HotelSuccess(
          hotels: allHotelsResponse.data,
          nearbyHotels: nearbyHotelsResponse.data,
          recommendedHotels: recommendedHotelsResponse.data,
          availableRooms: [],
        ),
      );
    } catch (e) {
      emit(HotelError('Failed to fetch hotels: ${e.toString()}'));
    }
  }

  // ✨ Fixed: This method should emit loading state first
  Future<void> fetchAvailableRooms() async {
    emit(HotelLoading()); // 🔥 Add loading state
    try {
      final roomsResponse = await _repository.getAvailableRooms();

      // Check if we have previous hotel data
      final currentState = state;
      List<HotelModel> hotels = [];
      List<HotelModel> nearbyHotels = [];
      List<HotelModel> recommendedHotels = [];

      if (currentState is HotelSuccess) {
        hotels = currentState.hotels;
        nearbyHotels = currentState.nearbyHotels;
        recommendedHotels = currentState.recommendedHotels;
      }

      print(
        'Available Rooms fetched: ${roomsResponse.data.length}',
      ); // Debug log

      emit(
        HotelSuccess(
          hotels: hotels,
          nearbyHotels: nearbyHotels,
          recommendedHotels: recommendedHotels,
          availableRooms: roomsResponse.data,
        ),
      );
    } catch (e) {
      print('Error in fetchAvailableRooms: $e'); // Debug log
      emit(HotelError('Failed to fetch rooms: ${e.toString()}'));
    }
  }

  Future<void> searchHotels(String query) async {
    // Don't search if query is too short
    if (query.trim().length < 2) return;

    // Get current state data to preserve it
    final currentState = state;
    List<HotelModel> hotels = [];
    List<HotelModel> nearbyHotels = [];
    List<HotelModel> recommendedHotels = [];
    List<RoomModel> availableRooms = [];

    if (currentState is HotelSuccess) {
      hotels = currentState.hotels;
      nearbyHotels = currentState.nearbyHotels;
      recommendedHotels = currentState.recommendedHotels;
      availableRooms = currentState.availableRooms;
    }

    emit(HotelSearchLoading());
    try {
      final searchResponse = await _repository.searchHotels(query);

      print(
        '🔍 Search Results: ${searchResponse.data.length} hotels found for "$query"',
      );

      // ✨ Emit same state but with search results
      emit(
        HotelSuccess(
          hotels: hotels,
          nearbyHotels: nearbyHotels,
          recommendedHotels: recommendedHotels,
          availableRooms: availableRooms,
          searchResults: searchResponse.data,
          searchQuery: query,
          isSearchMode: true,
        ),
      );
    } catch (e) {
      print('❌ Error in searchHotels: $e');
      // Return to normal state on error
      emit(
        HotelSuccess(
          hotels: hotels,
          nearbyHotels: nearbyHotels,
          recommendedHotels: recommendedHotels,
          availableRooms: availableRooms,
          isSearchMode: false,
        ),
      );
      // Show error message
      emit(HotelError('Failed to search hotels: ${e.toString()}'));
    }
  }

  void clearSearch() {
    final currentState = state;
    if (currentState is HotelSuccess) {
      emit(
        HotelSuccess(
          hotels: currentState.hotels,
          nearbyHotels: currentState.nearbyHotels,
          recommendedHotels: currentState.recommendedHotels,
          availableRooms: currentState.availableRooms,
          isSearchMode: false,
        ),
      );
    } else {
      fetchAllHotelsData();
    }
  }
}
