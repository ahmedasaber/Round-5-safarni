import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safarni/core/helpers/token_manger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(milliseconds: 2000);

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
        },
      ),
    );
  
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          
          final token = await TokenManager.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          } else {
          }
          
          handler.next(options);
        },
        onError: (error, handler) async {

          if (error.response?.statusCode == 401) {
            await TokenManager.clearTokens();
            // NavigationService.navigateToLogin();
          }
          
          handler.next(error);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }  
  static Future<void> updateToken(String token) async {
    await TokenManager.saveToken(token);
    if (dio != null) {
      dio!.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  static Future<void> clearToken() async {
    await TokenManager.clearTokens();
    if (dio != null) {
      dio!.options.headers.remove('Authorization');
    }
  }
}