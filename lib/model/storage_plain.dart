import 'package:shared_preferences/shared_preferences.dart';

class StoragePlain {
  late SharedPreferences prefs;
  // Save token
  Future<void> saveStorageData({
    required String key,
    required dynamic value,
  }) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

// Retrieve token
  Future<String?> getStorageData({
    required String key,
  }) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
