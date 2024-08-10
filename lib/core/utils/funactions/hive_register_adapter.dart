import 'package:hive/hive.dart';

import '../../../Features/home/domain/entities/categories_entity/categories_entity.dart';
import '../../../Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import '../../../Features/home/domain/entities/products_entity/product_entity.dart';

void HiveRegisterAdapters() {
  Hive.registerAdapter(
    ProductEntityAdapter(),
  );
  Hive.registerAdapter(
    CategoriesEntityAdapter(),
  );
  Hive.registerAdapter(
    FavouritesEntityAdapter(),
  );
  // Hive.registerAdapter(
  //   AddToCartEntityAdapter(),
  // );
}
