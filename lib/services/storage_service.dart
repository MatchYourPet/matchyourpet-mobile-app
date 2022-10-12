import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveToStorage(String key, value) async {
    await _secureStorage.write(
        key: key, value: value, aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(String key) async {
    var readData =
    await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
}