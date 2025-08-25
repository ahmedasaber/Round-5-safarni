import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
    
    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          print('❌ API Error: ${error.message}');
          print('🔗 URL: ${error.requestOptions.uri}');
          print('📊 Status Code: ${error.response?.statusCode}');
          handler.next(error);
        },
        onRequest: (options, handler) {
          print('🚀 Sending request to: ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Response received: ${response.statusCode}');
          handler.next(response);
        },
      ),
    );
  }
}