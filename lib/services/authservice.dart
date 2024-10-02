import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static bool _isLoggedIn = false;

  // Private constructor to prevent instantiation
  AuthService._();

  // Call this method during app initialization to check the login status
  static Future<void> initialize() async {
    String? token = await _storage.read(key: 'authToken');
    _isLoggedIn = token != null;
  }

  static Future<void> login(String username, String password) async {
    // mock data token = '1' every time for demo purposes
    const token = '1';

    // Store the token securely
    await _storage.write(key: 'authToken', value: token);
    _isLoggedIn = true;

    Get.offNamed('/home');
  }

  static Future<void> logout() async {
    // Remove the stored token
    await _storage.delete(key: 'authToken');
    _isLoggedIn = false;

    // Navigate to login page after logout
    Get.offAllNamed('/login');
  }

  // Use this method to check if the user is logged in
  static bool checkIsLoggedIn() {
    return _isLoggedIn;
  }
}
