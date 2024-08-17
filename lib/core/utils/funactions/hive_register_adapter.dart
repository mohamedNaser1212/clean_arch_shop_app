import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';

import '../../../Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import '../../../Features/home/domain/entities/categories_entity/categories_entity.dart';
import '../../../Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import '../../../Features/home/domain/entities/products_entity/product_entity.dart';

void HiveRegisterAdapters() {
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(CategoriesEntityAdapter());
  Hive.registerAdapter(FavouritesEntityAdapter());
  Hive.registerAdapter(AddToCartEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
}
