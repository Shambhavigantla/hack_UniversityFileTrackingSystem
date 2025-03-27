// lib/controllers/login_controller.dart
import 'package:get/get.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final loginId = ''.obs; // This can be either email or username
  final password = ''.obs;
  final error = ''.obs;

  void login() {
    if (loginId.value == 'admin' && password.value == 'admin123') {
      Get.offNamed('/admin-dashboard',
          arguments: UserModel(
              username: loginId.value,
              password: password.value,
              isAdmin: true));
    } else if (loginId.value == 'user' && password.value == 'user123') {
      Get.offNamed('/user-dashboard',
          arguments:
              UserModel(username: loginId.value, password: password.value));
    } else if (loginId.value == 'user@example.com' &&
        password.value == 'user123') {
      Get.offNamed('/user-dashboard',
          arguments: UserModel(
            username: 'user',
            password: password.value,
            // email: loginId.value
          ));
    } else {
      error.value = 'Invalid login ID or password !!';
    }
  }
}
