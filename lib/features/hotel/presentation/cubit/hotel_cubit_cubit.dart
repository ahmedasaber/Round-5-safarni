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

      if (!isClosed) {
        emit(
          HotelSuccess(
            hotels: allHotelsResponse.data,
            nearbyHotels: nearbyHotelsResponse.data,
            recommendedHotels: recommendedHotelsResponse.data,
            availableRooms: [],
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(HotelError(message: 'Failed to fetch hotels: ${e.toString()}'));
      }
    }
  }

  Future<void> fetchAvailableRooms({int? hotelId}) async {
    print('🎯 HotelCubit - fetchAvailableRooms called with hotelId: $hotelId');
    emit(HotelLoading());

    try {
      _currentHotelId = hotelId;

      print('📡 Calling repository.getAvailableRooms with hotelId: $hotelId');
      final roomsResponse = await _repository.getAvailableRooms(
        hotelId: hotelId,
      );

      print('📊 Repository returned ${roomsResponse.data.length} rooms');
      print(
        '📋 Rooms data: ${roomsResponse.data.map((r) => 'ID:${r.id}, Name:${r.name}').toList()}',
      );

      if (!isClosed) {
        if (state is HotelSuccess) {
          final currentState = state as HotelSuccess;
          print(
            '✅ Updating existing HotelSuccess state with ${roomsResponse.data.length} rooms',
          );
          emit(
            HotelSuccess(
              recommendedHotels: currentState.recommendedHotels,
              nearbyHotels: currentState.nearbyHotels,
              availableRooms:
                  roomsResponse.data, // ⭐ هنا المفروض يجي فاضي لو مفيش غرف
              isSearchMode: currentState.isSearchMode,
              searchResults: currentState.searchResults,
              searchQuery: currentState.searchQuery,
              hotels: currentState.hotels,
            ),
          );
        } else {
          print(
            '✅ Creating new HotelSuccess state with ${roomsResponse.data.length} rooms',
          );
          emit(
            HotelSuccess(
              recommendedHotels: [],
              nearbyHotels: [],
              availableRooms:
                  roomsResponse.data, // ⭐ هنا المفروض يجي فاضي لو مفيش غرف
              isSearchMode: false,
              searchResults: null,
              searchQuery: null,
              hotels: [],
            ),
          );
        }
      }
    } catch (e) {
      if (!isClosed) {
        print('❌ Error in fetchAvailableRooms: $e');
        emit(HotelError(message: 'Failed to fetch rooms: ${e.toString()}'));
      }
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

      if (!isClosed) {
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
      }
    } catch (e) {
      print('❌ Error in searchHotels: $e');
      if (!isClosed) {
        emit(HotelError(message: 'Failed to search hotels: ${e.toString()}'));
      }
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
