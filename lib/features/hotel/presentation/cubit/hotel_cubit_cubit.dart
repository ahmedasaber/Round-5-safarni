import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/hotel/data/models/hotels_response_model.dart';
import 'package:safarni/features/hotel/data/models/rooms_response_model.dart';
import 'package:safarni/features/hotel/data/repositories/hotel_repository.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository _hotelRepository;

  HotelCubit(this._hotelRepository) : super(HotelInitial());

  List<HotelModel> allHotels = [];
  List<HotelModel> nearbyHotels = [];
  List<HotelModel> recommendedHotels = [];
  List<RoomModel> availableRooms = [];

  Future<void> fetchAllHotelsData() async {
    if (isClosed) return;
    emit(HotelLoading());
    try {
      final allHotelsResponse = await _hotelRepository.getAllHotels();
      if (isClosed) return;
      
      final nearbyHotelsResponse = await _hotelRepository.getNearbyHotels();
      if (isClosed) return;
      
      final recommendedHotelsResponse = await _hotelRepository.getRecommendedHotels();
      if (isClosed) return;
      allHotels = allHotelsResponse.data;
      nearbyHotels = nearbyHotelsResponse.data;
      recommendedHotels = recommendedHotelsResponse.data;
      emit(HotelSuccess(
        hotels: allHotels,
        nearbyHotels: nearbyHotels,
        recommendedHotels: recommendedHotels,
        availableRooms: availableRooms,
      ));
    } catch (e) {
      if (!isClosed) {
        emit(HotelError(e.toString()));
      }
    }
  }
  Future<void> fetchAvailableRooms() async {
    if (isClosed) return;
    emit(HotelLoading());
    try {
      final response = await _hotelRepository.getAvailableRooms();
      
      if (isClosed) return;
      
      availableRooms = response.data;
      
      emit(HotelSuccess(
        hotels: allHotels,
        nearbyHotels: nearbyHotels,
        recommendedHotels: recommendedHotels,
        availableRooms: availableRooms,
      ));
    } catch (e) {
      if (!isClosed) {
        emit(HotelError(e.toString()));
      }
    }
  }
  Future<void> fetchAllData() async {
    if (isClosed) return;
    emit(HotelLoading());
    try {
      final futures = await Future.wait([
        _hotelRepository.getAllHotels(),
        _hotelRepository.getNearbyHotels(), 
        _hotelRepository.getRecommendedHotels(),
        _hotelRepository.getAvailableRooms(),
      ]);
      if (isClosed) return;
      final allHotelsResult = futures[0];
      final nearbyHotelsResult = futures[1]; 
      final recommendedHotelsResult = futures[2];
      final availableRoomsResult = futures[3];
      if (allHotelsResult is HotelsResponseModel) {
        allHotels = allHotelsResult.data;
      }
      if (nearbyHotelsResult is HotelsResponseModel) {
        nearbyHotels = nearbyHotelsResult.data;
      }
      if (recommendedHotelsResult is HotelsResponseModel) {
        recommendedHotels = recommendedHotelsResult.data;
      }
      if (availableRoomsResult is RoomsResponseModel) {
        availableRooms = availableRoomsResult.data;
      }

      emit(HotelSuccess(
        hotels: allHotels,
        nearbyHotels: nearbyHotels,
        recommendedHotels: recommendedHotels,
        availableRooms: availableRooms,
      ));
    } catch (e) {
      if (!isClosed) {
        emit(HotelError(e.toString()));
      }
    }
  }
}