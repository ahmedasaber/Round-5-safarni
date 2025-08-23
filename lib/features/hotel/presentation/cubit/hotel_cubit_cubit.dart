import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';
import 'package:safarni/features/hotel/data/repositories/hotel_repository.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository _repository;

  HotelCubit(this._repository) : super(HotelInitial());
  int? _currentHotelId;

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
      emit(HotelError(message: 'Failed to fetch hotels: ${e.toString()}'));
    }
  }

  Future<void> fetchAvailableRooms({int? hotelId}) async {
    emit(HotelLoading());
    try {
      _currentHotelId = hotelId;

      final roomsResponse = await _repository.getAvailableRooms(
        hotelId: hotelId,
      );

      if (state is HotelSuccess) {
        final currentState = state as HotelSuccess;
        emit(
          HotelSuccess(
            recommendedHotels: currentState.recommendedHotels,
            nearbyHotels: currentState.nearbyHotels,
            availableRooms: roomsResponse.data,
            isSearchMode: currentState.isSearchMode,
            searchResults: currentState.searchResults,
            searchQuery: currentState.searchQuery,
            hotels: currentState.hotels,
          ),
        );
      } else {
        emit(
          HotelSuccess(
            recommendedHotels: [],
            nearbyHotels: [],
            availableRooms: roomsResponse.data,
            isSearchMode: false,
            searchResults: null,
            searchQuery: null,
            hotels: [],
          ),
        );
      }
    } catch (e) {
      emit(HotelError(message: e.toString()));
    }
  }

  Future<void> searchHotels(String query) async {
    if (query.trim().length < 2) return;

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
      emit(HotelError(message: 'Failed to search hotels: ${e.toString()}'));
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
