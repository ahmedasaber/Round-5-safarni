class ApiConstants {
  static const String baseUrl = 'http://round5-safarnia.huma-volve.com/api/';
  static const String getAllHotels = '${baseUrl}hotels';
  static const String getNearbyHotels = '${baseUrl}hotels';
  static const String getRecommendedHotels = '${baseUrl}hotels';
  
  static const String getAvailableRooms = '${baseUrl}hotel/rooms/3';
  
  static const String getRoomDetails = '${baseUrl}room/details/1';
  static const String searchHotels = '${baseUrl}hotels/search';
  static String getHotelRooms(int hotelId) {
    return '${baseUrl}hotel/rooms/$hotelId';
  }
}