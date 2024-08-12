import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import '../../../Features/home/domain/entities/user_entity/user_entity.dart';

Future<void> hiveOpenBoxes() async {
  await Hive.openBox<ProductEntity>(kProductsBox);
  await Hive.openBox<CategoriesEntity>(kCategoriesBox);
  await Hive.openBox<FavouritesEntity>(kFavouritesBox);
  await Hive.openBox<AddToCartEntity>(kCartBox);
  await Hive.openBox<UserEntity>(kUserBox); // Open the UserEntity box
}
