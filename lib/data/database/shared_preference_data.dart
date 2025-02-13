import 'package:maha/core.dart';

class PreferenceHelper {
  Future<void> saveBoolValue(String boolKey, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(boolKey, value);
  }

  Future<bool> getBoolValue(
    String boolKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(boolKey) ?? false;
  }

  Future<void> removeBoolValue(
    String boolKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(boolKey);
  }
}
