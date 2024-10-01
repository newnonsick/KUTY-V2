import 'package:get/get.dart';

class AuthService extends GetxService {
  var isLoggedIn = false.obs;

  // You can add any additional initialization logic here if needed
  AuthService() {
    // Optional: Perform any setup or loading tasks if necessary
  }

  Future<void> login(String username, String password) async {
    // Logic to log in the user (e.g., set isLoggedIn to true)
    isLoggedIn.value = true;
    print('Login successful, isLoggedIn: ${isLoggedIn.value}');
    Get.offNamed('/home');
  }

  Future<void> logout() async {
    // Logic to log out the user (e.g., set isLoggedIn to false)
    isLoggedIn.value = false;
  }
}
