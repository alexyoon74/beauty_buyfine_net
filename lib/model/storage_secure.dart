import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageSecure {
  final _storage = const FlutterSecureStorage();

  // Save keycode securely
  Future<void> saveStorageData({
    required String key,
    required dynamic value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  // Retrieve keycode securely
  Future<String?> getStorageData({
    required String key,
  }) async {
    return await _storage.read(key: key);
  }
}
