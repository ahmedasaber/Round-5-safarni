  import 'package:safarni/core/services/hotel_api_services.dart';
  import 'package:safarni/features/hotel/data/models/hotels_response_model.dart';
  import 'package:safarni/features/hotel/data/models/rooms_response_model.dart';
  import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';

  abstract class HotelRepository {
    Future<HotelsResponseModel> getAllHotels();
    Future<HotelsResponseModel> getNearbyHotels();
    Future<HotelsResponseModel> getRecommendedHotels();
    Future<RoomsResponseModel> getAvailableRooms({int? hotelId}); // Updated ⭐
    Future<RoomDetailResponse> getRoomDetails(int roomId);
    Future<HotelsResponseModel> searchHotels(String query);
  }

  class HotelRepositoryImpl implements HotelRepository {
    final HotelApiService _hotelApiService;

    HotelRepositoryImpl(this._hotelApiService);

    @override
    Future<HotelsResponseModel> searchHotels(String query) async {
      return await _hotelApiService.searchHotels(query);
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
      print('📡 Repository calling API with hotel ID: $hotelId');
      return await _hotelApiService.getAvailableRooms(
        hotelId: hotelId,
      ); // Updated ⭐
    }

    @override
    Future<RoomDetailResponse> getRoomDetails(int roomId) async {
      return await _hotelApiService.getRoomDetails(roomId);
    }
  }
