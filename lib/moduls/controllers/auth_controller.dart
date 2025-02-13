import '../../core.dart';

class AuthController extends GetxController {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final preferenceHelper = PreferenceHelper();
  Future<void> registerUser(
      String name, String email, String phone, String password) async {
    Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };

    try {
      await dbHelper.createUser(userData);
      Get.snackbar("Success", "Registration Successful!",
          snackPosition: SnackPosition.BOTTOM);
      await preferenceHelper.saveBoolValue(boolKeyRegistred, true);
      Get.offAll(() => LoginPage());
    } catch (e) {
      Get.snackbar("Error", "Failed to register user.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loginUser(
      String emailOrPhone, String password, bool keyLogin) async {
    try {
      final user = await dbHelper.getUserByEmailOrPhone(emailOrPhone);

      if (user != null && user['password'] == password) {
        Get.snackbar("Success", "Login Successful!",
            snackPosition: SnackPosition.BOTTOM);
        await preferenceHelper.saveBoolValue(boolKeyLogin, keyLogin);
        Get.offAll(() => ItemListPage());
      } else {
        Get.snackbar("Error", "Invalid credentials. Please try again.",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred during login.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
