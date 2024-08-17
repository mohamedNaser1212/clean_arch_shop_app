import 'package:hive/hive.dart';

import '../../../Features/carts_feature/domain/add_to_cart_entity/add_to_cart_entity.dart';
import '../../../Features/favourites_feature/domain/favourites_entity/favourites_entity.dart';

import '../../../Features/home/domain/entities/categories_entity/categories_entity.dart';
import '../../../Features/home/domain/entities/products_entity/product_entity.dart';
import '../../../Features/settings_feature/domain/user_entity/user_entity.dart';

void HiveRegisterAdapters() {
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(CategoriesEntityAdapter());
  Hive.registerAdapter(FavouritesEntityAdapter());
  Hive.registerAdapter(AddToCartEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
}
