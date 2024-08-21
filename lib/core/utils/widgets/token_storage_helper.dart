import 'package:hive/hive.dart';

class HiveHelper {
  static late Box<dynamic> hiveBox;
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (!_isInitialized) {
      hiveBox = await Hive.openBox('userBox');
      _isInitialized = true;
    }
  }

  static void _checkInitialization() {
    if (!_isInitialized) {
      throw StateError(
          'HiveHelper is not initialized. Call HiveHelper.init() before accessing the Hive box.');
    }
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    _checkInitialization();
    await hiveBox.put(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    _checkInitialization();
    return hiveBox.get(key);
  }

  static Future<void> removeData({
    required String key,
  }) async {
    _checkInitialization();
    await hiveBox.delete(key);
  }

  static String getToken() {
    _checkInitialization();
    return hiveBox.get('token')??'';
  }
}
