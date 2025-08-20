import 'package:dio/dio.dart';
import 'package:safarni/core/helpers/constants.dart';
import 'package:safarni/features/hotel/data/models/hotels_response_model.dart';
import 'package:safarni/features/hotel/data/models/rooms_response_model.dart';

class HotelApiService {
  final Dio _dio;

  HotelApiService(this._dio);

  Future<HotelsResponseModel> getAllHotels() async {
    try {
      final response = await _dio.get(ApiConstants.getAllHotels);

      return HotelsResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch hotels: $e');
    }
  }

  Future<HotelsResponseModel> getNearbyHotels() async {
    try {
      final response = await _dio.get(ApiConstants.getNearbyHotels);

      return HotelsResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch nearby hotels: $e');
    }
  }

  Future<HotelsResponseModel> getRecommendedHotels() async {
    try {
      final response = await _dio.get(ApiConstants.getRecommendedHotels);

      return HotelsResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch recommended hotels: $e');
    }
  }

  Future<RoomsResponseModel> getAvailableRooms() async {
    try {
      final response = await _dio.get(ApiConstants.getAvailableRooms);

      return RoomsResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch available rooms: $e');
    }
  }
}
