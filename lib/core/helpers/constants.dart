class ApiConstants {
  static const String baseUrl = 'http://round5-safarnia.huma-volve.com/api/';
  
  // Existing constants
  static const String getAllHotels = '${baseUrl}hotels';
  static const String getNearbyHotels = '${baseUrl}hotels';
  static const String getRecommendedHotels = '${baseUrl}hotels';
  static const String getAvailableRooms = '${baseUrl}hotel/rooms';
  static const String getRoomDetails = '${baseUrl}room/details/1';
  static const String searchHotels = '${baseUrl}hotels/search';
  static const String searchRooms = '${baseUrl}rooms/search';
  
  // Profile API endpoints
  static const String getUserProfile = '${baseUrl}profile';
  static const String updateUserProfile = '${baseUrl}profile';
  static const String changePassword = '${baseUrl}profile/update-password';
  static const String deleteAccount = '${baseUrl}profile/delete-account';
  
  static String getHotelRooms(int hotelId) {
    return '${baseUrl}hotel/rooms/$hotelId';
  }
}