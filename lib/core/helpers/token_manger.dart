import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  // حفظ التوكن مع معالجة الأخطاء
  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      debugPrint('✅ Token saved successfully');
    } catch (e) {
      debugPrint('❌ Error saving token: $e');
      rethrow;
    }
  }

  // جلب التوكن مع معالجة الأخطاء
  static Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      debugPrint('🔍 Token retrieved: ${token != null ? 'Found' : 'Not found'}');
      return token;
    } catch (e) {
      debugPrint('❌ Error reading token: $e');
      return null; // إرجاع null بدلاً من رمي الخطأ
    }
  }

  // حفظ الـ refresh token
  static Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
      debugPrint('✅ Refresh token saved successfully');
    } catch (e) {
      debugPrint('❌ Error saving refresh token: $e');
      rethrow;
    }
  }

  // جلب الـ refresh token
  static Future<String?> getRefreshToken() async {
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      debugPrint('🔍 Refresh token retrieved: ${refreshToken != null ? 'Found' : 'Not found'}');
      return refreshToken;
    } catch (e) {
      debugPrint('❌ Error reading refresh token: $e');
      return null;
    }
  }

  // مسح كل التوكنز (للخروج)
  static Future<void> clearTokens() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _refreshTokenKey);
      debugPrint('✅ All tokens cleared successfully');
    } catch (e) {
      debugPrint('❌ Error clearing tokens: $e');
      rethrow;
    }
  }

  // فحص إذا كان التوكن موجود مع معالجة آمنة للأخطاء
  static Future<bool> hasToken() async {
    try {
      final token = await getToken();
      final hasValidToken = token != null && token.isNotEmpty;
      debugPrint('🔐 Token check result: $hasValidToken');
      return hasValidToken;
    } catch (e) {
      debugPrint('❌ Error checking token existence: $e');
      return false; // إرجاع false في حالة الخطأ (المستخدم غير مسجل دخول)
    }
  }

  // دالة إضافية لفحص صحة التوكن
  static Future<bool> isTokenValid() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        return false;
      }
      
      // يمكنك إضافة منطق إضافي هنا للتحقق من انتهاء صلاحية التوكن
      // مثلاً فك تشفير JWT والتحقق من تاريخ الانتهاء
      
      return true;
    } catch (e) {
      debugPrint('❌ Error validating token: $e');
      return false;
    }
  }

  // دالة لمسح البيانات في حالة الطوارئ
  static Future<void> emergencyCleanup() async {
    try {
      await _storage.deleteAll();
      debugPrint('🧹 Emergency cleanup completed');
    } catch (e) {
      debugPrint('❌ Error during emergency cleanup: $e');
    }
  }
}