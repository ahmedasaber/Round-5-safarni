import 'package:dio/dio.dart';
import 'package:safarni/core/helpers/constants.dart';
import 'package:safarni/features/hotel/data/models/hotels_response_model.dart';
import 'package:safarni/features/hotel/data/models/rooms_response_model.dart';
import 'package:safarni/features/hotel_about/data/model/booking_data_model.dart';
import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';

class HotelApiService {
  final Dio _dio;

  HotelApiService(this._dio);

  Future<HotelsResponseModel> searchHotels(String query) async {
    try {
      print('🔍 Searching hotels with query: $query');
      print('🚀 Search URL: ${ApiConstants.searchHotels}?key=$query');

      final response = await _dio.get(
        ApiConstants.searchHotels,
        queryParameters: {
          'key': query, // حسب الـ API اللي شفته في الصورة
        },
      );

      print('✅ Search Response status: ${response.statusCode}');
      print('📊 Search Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception(
          'Invalid search response: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ Dio error in searchHotels: ${e.message}');
      print('🔍 Error type: ${e.type}');
      print('📋 Error response: ${e.response?.data}');
      throw Exception('Network error: ${e.message}');
    } catch (e, stackTrace) {
      print('💥 General error in searchHotels: $e');
      print('📍 Stack trace: $stackTrace');
      throw Exception('Failed to search hotels: $e');
    }
  }

  Future<HotelsResponseModel> getAllHotels() async {
    try {
      print('🚀 Fetching all hotels from: ${ApiConstants.getAllHotels}');
      final response = await _dio.get(ApiConstants.getAllHotels);

      print('✅ Response status: ${response.statusCode}');
      print('📝 Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error in getAllHotels: ${e.message}');
      print('🔍 Error type: ${e.type}');
      print('📋 Error response: ${e.response?.data}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('💥 General error in getAllHotels: $e');
      throw Exception('Failed to fetch hotels: $e');
    }
  }

  Future<HotelsResponseModel> getNearbyHotels() async {
    try {
      print('🚀 Fetching nearby hotels from: ${ApiConstants.getNearbyHotels}');
      final response = await _dio.get(ApiConstants.getNearbyHotels);

      print('✅ Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error in getNearbyHotels: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('💥 General error in getNearbyHotels: $e');
      throw Exception('Failed to fetch nearby hotels: $e');
    }
  }

  Future<HotelsResponseModel> getRecommendedHotels() async {
    try {
      print(
        '🚀 Fetching recommended hotels from: ${ApiConstants.getRecommendedHotels}',
      );
      final response = await _dio.get(ApiConstants.getRecommendedHotels);

      print('✅ Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        return HotelsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error in getRecommendedHotels: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('💥 General error in getRecommendedHotels: $e');
      throw Exception('Failed to fetch recommended hotels: $e');
    }
  }

  Future<RoomsResponseModel> getAvailableRooms({int? hotelId}) async {
    try {
      String endpoint;

      // Build endpoint based on whether hotel ID is provided
      if (hotelId != null) {
        // ✅ استخدام الدالة المساعدة من ApiConstants
        endpoint = ApiConstants.getHotelRooms(hotelId);
        print('🏨 Fetching rooms for hotel ID: $hotelId from: $endpoint');
      } else {
        // ✅ إذا مفيش هوتل ID، جيب كل الغرف المتاحة
        endpoint = ApiConstants.getAvailableRooms;
        print('🏨 Fetching all available rooms from: $endpoint');
      }

      print('📅 Current date: ${DateTime.now().toString()}');

      final response = await _dio.get(endpoint);

      print('✅ Rooms Response status: ${response.statusCode}');
      print('📊 Raw response data: ${response.data}');

      if (response.data != null) {
        print('🔍 Response structure:');
        print('  - Status: ${response.data['status']}');
        print('  - Message: ${response.data['message']}');
        print('  - Data type: ${response.data['data'].runtimeType}');
        print('  - Data length: ${response.data['data']?.length ?? 0}');
        if (response.data['data'] is List) {
          final rooms = response.data['data'] as List;
          for (int i = 0; i < rooms.length; i++) {
            print('  - Room $i: ${rooms[i]}');
          }
        }
      }

      if (response.statusCode == 200 && response.data != null) {
        final roomsResponse = RoomsResponseModel.fromJson(response.data);
        print('✅ Successfully parsed ${roomsResponse.data.length} rooms');
        return roomsResponse;
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error in getAvailableRooms: ${e.message}');
      print('🔍 Error type: ${e.type}');
      print('📋 Error response: ${e.response?.data}');
      print('🌐 Request URL: ${e.requestOptions.path}');
      throw Exception('Network error: ${e.message}');
    } catch (e, stackTrace) {
      print('💥 General error in getAvailableRooms: $e');
      print('📍 Stack trace: $stackTrace');
      throw Exception('Failed to fetch available rooms: $e');
    }
  }

  Future<RoomDetailResponse> getRoomDetails(int roomId) async {
    try {
      print('🏨 Fetching room details for room ID: $roomId');
      final response = await _dio.get(
        '${ApiConstants.baseUrl}room/details/$roomId',
      );

      print('✅ Room details response status: ${response.statusCode}');
      print('📊 Room details raw response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final roomDetailResponse = RoomDetailResponse.fromJson(response.data);
        print('✅ Successfully parsed room details');
        return roomDetailResponse;
      } else {
        throw Exception('Invalid response: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error in getRoomDetails: ${e.message}');
      print('🔍 Error type: ${e.type}');
      print('📋 Error response: ${e.response?.data}');
      throw Exception('Network error: ${e.message}');
    } catch (e, stackTrace) {
      print('💥 General error in getRoomDetails: $e');
      print('📍 Stack trace: $stackTrace');
      throw Exception('Failed to fetch room details: $e');
    }
  }

  Future<BookingResponse> bookRoom(BookingRequest bookingRequest) async {
    try {
      print('🚀 Booking room with data: ${bookingRequest.toJson()}');

      final response = await _dio.post(
        '${ApiConstants.baseUrl}booking/room',
        data: bookingRequest.toJson(),
      );

      print('✅ Booking response status: ${response.statusCode}');
      print('📊 Booking response data: ${response.data}');

      if (response.statusCode == 201 && response.data != null) {
        final bookingResponse = BookingResponse.fromJson(response.data);
        print('✅ Room booked successfully with ID: ${bookingResponse.data.id}');
        return bookingResponse;
      } else {
        throw Exception(
          'Invalid booking response: Status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ Dio error in bookRoom: ${e.message}');
      print('🔍 Error type: ${e.type}');
      print('📋 Error response: ${e.response?.data}');

      String errorMessage = 'Network error occurred';
      if (e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          errorMessage = e.response!.data['message'] ?? errorMessage;
        }
      }
      throw Exception(errorMessage);
    } catch (e, stackTrace) {
      print('💥 General error in bookRoom: $e');
      print('📍 Stack trace: $stackTrace');
      throw Exception('Failed to book room: $e');
    }
  }
}
