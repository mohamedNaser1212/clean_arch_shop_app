import 'package:hive_flutter/hive_flutter.dart';

import '../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import '../../../Features/favourites_feature/domain/favourites_entity/favourites_entity.dart';
import '../../../Features/home/domain/entities/categories_entity/categories_entity.dart';
import '../../../Features/home/domain/entities/products_entity/product_entity.dart';
import '../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../../utils/screens/widgets/end_points.dart';

class HiveManager {
  static final Map<String, Box> _openedBoxes = {};

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductEntityAdapter());
    Hive.registerAdapter(CategoriesEntityAdapter());
    Hive.registerAdapter(FavouritesEntityAdapter());
    Hive.registerAdapter(AddToCartEntityAdapter());
    Hive.registerAdapter(UserEntityAdapter());
    await _openAllBoxes();
  }

  static Future<void> _openAllBoxes() async {
    await Future.wait([
      _openBox<ProductEntity>(kProductsBox),
      _openBox<CategoriesEntity>(kCategoriesBox),
      _openBox<FavouritesEntity>(kFavouritesBox),
      _openBox<AddToCartEntity>(kCartBox),
      _openBox<UserEntity>(kUserBox),
    ]);
  }

  static Future<void> _openBox<T>(String boxName) async {
    try {
      if (!_openedBoxes.containsKey(boxName)) {
        final box = await Hive.openBox<T>(boxName);
        _openedBoxes[boxName] = box;
      }
    } catch (e) {
      print('Failed to open box $boxName: $e');
      throw Exception("Box $boxName could not be opened.");
    }
  }

  static Box<T> _getBox<T>(String boxName) {
    final box = _openedBoxes[boxName] as Box<T>?;
    if (box == null) {
      throw Exception("Box $boxName is not opened.");
    }
    return box;
  }

  static Future<void> saveData<T>(List<T> data, String boxName) async {
    var box = _getBox<T>(boxName);
    await box.clear();
    await box.addAll(data);
  }

  static Future<List<T>> loadData<T>(String boxName) async {
    var box = _getBox<T>(boxName);
    return box.values.toList();
  }

  static Future<void> saveSingleItem<T>(
      String key, T item, String boxName) async {
    var box = _getBox<T>(boxName);
    await box.put(key, item);
  }

  static Future<T?> loadSingleItem<T>(String key, String boxName) async {
    var box = _getBox<T>(boxName);
    return box.get(key);
  }

  static Future<void> clearData<T>(String boxName) async {
    var box = _getBox<T>(boxName);
    await box.clear();
  }

  static Future<void> clearSingleItem<T>(String key, String boxName) async {
    var box = _getBox<T>(boxName);
    await box.delete(key);
  }
}
