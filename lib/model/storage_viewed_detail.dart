import 'package:shared_preferences/shared_preferences.dart';

class StorageViewedDetail {
  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> addData({
    required String key,
    required int value,
  }) async {
    // Load existing data from SharedPreferences
    List<int> existingData = _prefs.getStringList(key)?.map((e) {
          return int.parse(e);
        }).toList() ??
        [];
    // Add the new value to the list
    if (existingData.contains(value)) {
      existingData.remove(value);
    }
    existingData.insert(0, value);
    if (existingData.length > 100) {
      existingData.removeLast();
    }
    // Save the updated list back to SharedPreferences
    _prefs.setStringList(
        key,
        existingData.map((e) {
          return e.toString();
        }).toList());
  }

  Map<String, List<int>> getData() {
    // Retrieve data from SharedPreferences
    Map<String, List<int>> data = {};

    for (String key in _prefs.getKeys()) {
      List<int> values = _prefs.getStringList(key)?.map((e) {
            return int.parse(e);
          }).toList() ??
          [];
      data[key] = values;
    }

    return data;
  }
}
