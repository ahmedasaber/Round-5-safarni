import 'package:dio/dio.dart';
import '../models/register_reques.dart';
import '../models/user_model.dart';
import '../models/auth_message_model.dart';
import '../models/otp_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(RegisterRequest request);
  Future<AuthMessageModel> forgotPassword(String email);
  Future<AuthMessageModel> updatePassword(String email, String newPassword);
  Future<OtpModel> verifyOtp(String email, String otp);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  static const String _base = 'https://round5-safarnia.huma-volve.com/api';

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      print('🔄 Attempting login for: $email');
      
      final res = await dio.post(
        '$_base/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print('✅ Login API Response: ${res.data}');
      
      // ✅ معالجة Response بشكل أفضل
      if (res.data != null) {
        // احتمال يكون التوكن في الـ root أو في data
        Map<String, dynamic> userData;
        
        if (res.data['data'] != null) {
          userData = res.data['data'];
        } else {
          userData = res.data;
        }
        
        // إضافة التوكن للـ user data لو مش موجود
        if (res.data['token'] != null && userData['token'] == null) {
          userData['token'] = res.data['token'];
        }
        
        return UserModel.fromJson(userData);
      } else {
        throw Exception("No data received from server");
      }
    } on DioException catch (e) {
      print('❌ Login Dio Error: ${e.response?.data}');
      
      if (e.response?.statusCode == 401) {
        throw Exception("البيانات غير صحيحة");
      } else if (e.response?.statusCode == 422) {
        throw Exception("تأكد من البيانات المدخلة");
      } else {
        throw Exception("خطأ في الشبكة");
      }
    } catch (e) {
      print('❌ Login General Error: $e');
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    try {
      print('🔄 Attempting registration for: ${request.email}');
      
      final response = await dio.post(
        '$_base/register',
        data: request.toJson(),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print('✅ Register API Response: ${response.data}');
      
      // معالجة Response بنفس الطريقة
      Map<String, dynamic> userData;
      
      if (response.data['data'] != null) {
        userData = response.data['data'];
      } else {
        userData = response.data;
      }
      
      if (response.data['token'] != null && userData['token'] == null) {
        userData['token'] = response.data['token'];
      }
      
      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      print('❌ Register Dio Error: ${e.response?.data}');
      
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null) {
          String errorMessage = '';
          errors.forEach((key, value) {
            if (value is List) {
              errorMessage += '${value.first}\n';
            }
          });
          throw Exception(errorMessage.trim());
        } else {
          throw Exception("تأكد من البيانات المدخلة");
        }
      } else {
        throw Exception("خطأ في الشبكة");
      }
    } catch (e) {
      print('❌ Register General Error: $e');
      throw Exception("Register failed: $e");
    }
  }

  @override
  Future<AuthMessageModel> forgotPassword(String email) async {
    try {
      print('🔄 Sending forgot password request for: $email');
      
      final res = await dio.post(
        '$_base/forgot-password',
        data: {
          'email': email,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print('✅ Forgot Password Response: ${res.data}');
      return AuthMessageModel.fromJson(res.data);
    } on DioException catch (e) {
      print('❌ Forgot Password Error: ${e.response?.data}');
      
      if (e.response?.statusCode == 404) {
        throw Exception("البريد الإلكتروني غير مسجل");
      } else {
        throw Exception("خطأ في إرسال رمز الاستعادة");
      }
    } catch (e) {
      throw Exception("Forgot password failed: $e");
    }
  }

  @override
  Future<AuthMessageModel> updatePassword(String email, String newPassword) async {
    try {
      final res = await dio.post(
        '$_base/update-password',
        data: {
          'email': email,
          'password': newPassword,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print('✅ Update Password Response: ${res.data}');
      return AuthMessageModel.fromJson(res.data);
    } catch (e) {
      print('❌ Update Password Error: $e');
      throw Exception("Update password failed: $e");
    }
  }

  @override
  Future<OtpModel> verifyOtp(String email, String otp) async {
    try {
      print('🔄 Verifying OTP: $otp for email: $email');
      
      final res = await dio.post(
        '$_base/otp',
        data: {
          'email': email,
          'otp': otp,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print('✅ Verify OTP Response: ${res.data}');
      return OtpModel.fromJson(res.data);
    } on DioException catch (e) {
      print('❌ Verify OTP Error: ${e.response?.data}');
      
      if (e.response?.statusCode == 400) {
        throw Exception("الرمز غير صحيح أو منتهي الصلاحية");
      } else {
        throw Exception("خطأ في التحقق من الرمز");
      }
    } catch (e) {
      throw Exception("Verify OTP failed: $e");
    }
  }
}