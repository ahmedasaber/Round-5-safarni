import 'package:dio/dio.dart';
import 'package:safarni/core/helpers/constants.dart';
import 'package:safarni/core/helpers/token_manger.dart';
import 'package:safarni/features/hotel/data/models/hotels_response_model.dart';
import 'package:safarni/features/hotel/data/models/rooms_response_model.dart';
import 'package:safarni/features/hotel_about/data/model/booking_data_model.dart';
import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';

class HotelApiService {
  final Dio _dio;

  HotelApiService(this._dio);

  Future<HotelsResponseModel> searchHotels(String query) async {
    try {

      final response = await _dio.get(
        ApiConstants.searchHotels,
        queryParameters: {'key': query},
      );


      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception(
          'Invalid search response: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search hotels: $e');
    }
  }

  // Add room search method
  Future<RoomsResponseModel> searchRooms(String query, {int? hotelId}) async {
    try {

      String endpoint = ApiConstants.searchRooms;
      Map<String, dynamic> queryParameters = {'key': query};

      // If hotelId is provided, add it to query parameters
      if (hotelId != null) {
        queryParameters['hotel_id'] = hotelId;
      }


      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );


      if (response.statusCode == 200 && response.data != null) {
        return RoomsResponseModel.fromJson(response.data);
      } else {
        throw Exception(
          'Invalid room search response: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search rooms: $e');
    }
  }

  Future<HotelsResponseModel> getAllHotels() async {
    try {
      final response = await _dio.get(ApiConstants.getAllHotels);


      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch hotels: $e');
    }
  }

  Future<HotelsResponseModel> getNearbyHotels() async {
    try {
      final response = await _dio.get(ApiConstants.getNearbyHotels);


      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch nearby hotels: $e');
    }
  }

  Future<HotelsResponseModel> getRecommendedHotels() async {
    try {
      final response = await _dio.get(ApiConstants.getRecommendedHotels);


      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch recommended hotels: $e');
    }
  }

  Future<RoomsResponseModel> getAvailableRooms({int? hotelId}) async {
    try {
      String endpoint;


      if (hotelId != null) {
        endpoint = ApiConstants.getHotelRooms(hotelId);
      } else {
        endpoint = ApiConstants.getAvailableRooms;
      }


      final response = await _dio.get(endpoint);


      if (response.data != null) {

        if (response.data['data'] is List) {
          final rooms = response.data['data'] as List;
          for (int i = 0; i < rooms.length && i < 3; i++) {
          }
        }
      }

      if (response.statusCode == 200 && response.data != null) {
        final roomsResponse = RoomsResponseModel.fromJson(response.data);
        return roomsResponse;
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch available rooms: $e');
    }
  }

  Future<RoomDetailResponse> getRoomDetails(int roomId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}room/details/$roomId',
      );


      if (response.statusCode == 200 && response.data != null) {
        final roomDetailResponse = RoomDetailResponse.fromJson(response.data);
        return roomDetailResponse;
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch room details: $e');
    }
  }

  Future<BookingResponse> bookRoom(BookingRequest bookingRequest) async {
    try {

      final response = await _dio.post(
        '${ApiConstants.baseUrl}booking/room',
        data: bookingRequest.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await TokenManager.getToken()}',
          },
        ),
      );


      if (response.statusCode == 201 && response.data != null) {
        final bookingResponse = BookingResponse.fromJson(response.data);
        return bookingResponse;
      } else {
        throw Exception(
          'Invalid booking response: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {

      String errorMessage = 'Network error occurred';
      if (e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          errorMessage = e.response!.data['message'] ?? errorMessage;
        }
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Failed to book room: $e');
    }
  }
}
