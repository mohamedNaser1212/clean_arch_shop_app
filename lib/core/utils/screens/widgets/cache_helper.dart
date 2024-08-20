import 'package:hive/hive.dart';

class HiveHelper {
  static late Box<dynamic> hiveBox;

  static Future<void> init() async {
    hiveBox = await Hive.openBox('userBox');
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    await hiveBox.put(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return hiveBox.get(key);
  }

  static Future<void> removeData({
    required String key,
  }) async {
    await hiveBox.delete(key);
  }
}
