import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safarni/core/helpers/token_manger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 60);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.sendTimeout = timeOut
        ..options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (object) {
          print('🌐 API: $object');
        },
      ),
    );

    // إضافة Interceptor للتوكن
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print('🚀 Sending request to: ${options.uri}');
          
          // جلب التوكن وإضافته للـ headers
          final token = await TokenManager.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print('🔐 Token added to request');
          } else {
            print('⚠️ No token found');
          }
          
          handler.next(options);
        },
        onError: (error, handler) async {
          print('❌ API Error: ${error.message}');
          print('🔗 URL: ${error.requestOptions.uri}');
          print('📊 Status Code: ${error.response?.statusCode}');
          
          // إذا كان الخطأ 401، امسح التوكن واعيد توجيه للتسجيل
          if (error.response?.statusCode == 401) {
            print('🚪 Session expired, clearing tokens');
            await TokenManager.clearTokens();
            // هنا ممكن تضيف navigation للـ login screen
            // NavigationService.navigateToLogin();
          }
          
          handler.next(error);
        },
        onResponse: (response, handler) {
          print('✅ Response received: ${response.statusCode}');
          handler.next(response);
        },
      ),
    );
  }

  // دالة لتحديث التوكن في الـ Dio headers
  static Future<void> updateToken(String token) async {
    await TokenManager.saveToken(token);
    if (dio != null) {
      dio!.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  // دالة لمسح التوكن من الـ Dio headers
  static Future<void> clearToken() async {
    await TokenManager.clearTokens();
    if (dio != null) {
      dio!.options.headers.remove('Authorization');
    }
  }
}