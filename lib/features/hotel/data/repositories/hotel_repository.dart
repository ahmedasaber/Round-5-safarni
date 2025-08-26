import 'package:safarni/core/services/hotel_api_services.dart';
import 'package:safarni/features/hotel/data/models/hotels_response_model.dart';
import 'package:safarni/features/hotel/data/models/rooms_response_model.dart';
import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';

abstract class HotelRepository {
  Future<HotelsResponseModel> getAllHotels();
  Future<HotelsResponseModel> getNearbyHotels();
  Future<HotelsResponseModel> getRecommendedHotels();
  Future<RoomsResponseModel> getAvailableRooms({int? hotelId});
  Future<RoomDetailResponse> getRoomDetails(int roomId);
  Future<HotelsResponseModel> searchHotels(String query);
  Future<RoomsResponseModel> searchRooms(String query, {int? hotelId}); // Add room search method
}

class HotelRepositoryImpl implements HotelRepository {
  final HotelApiService _hotelApiService;

  HotelRepositoryImpl(this._hotelApiService);

  @override
  Future<HotelsResponseModel> searchHotels(String query) async {
    return await _hotelApiService.searchHotels(query);
  }

  @override
  Future<RoomsResponseModel> searchRooms(String query, {int? hotelId}) async {
    return await _hotelApiService.searchRooms(query, hotelId: hotelId);
  }

  @override
  Future<HotelsResponseModel> getAllHotels() async {
    return await _hotelApiService.getAllHotels();
  }

  @override
  Future<HotelsResponseModel> getNearbyHotels() async {
    return await _hotelApiService.getNearbyHotels();
  }

  @override
  Future<HotelsResponseModel> getRecommendedHotels() async {
    return await _hotelApiService.getRecommendedHotels();
  }

  @override
  Future<RoomsResponseModel> getAvailableRooms({int? hotelId}) async {
    return await _hotelApiService.getAvailableRooms(hotelId: hotelId);
  }

  @override
  Future<RoomDetailResponse> getRoomDetails(int roomId) async {
    return await _hotelApiService.getRoomDetails(roomId);
  }
}