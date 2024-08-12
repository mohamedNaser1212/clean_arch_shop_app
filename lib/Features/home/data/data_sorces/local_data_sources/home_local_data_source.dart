import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';

import '../../../../../core/widgets/end_points.dart';

abstract class HomeLocalDataSource {
  List<ProductEntity> fetchProducts();
  List<CategoriesEntity> fetchCategories();
  List<FavouritesEntity> fetchFavourites();
  List<AddToCartEntity> fetchCarts();
  List<UserEntity> fetchUserData();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<CategoriesEntity> fetchCategories() {
    var categoriesBox = Hive.box<CategoriesEntity>(kCategoriesBox);
    return categoriesBox.values.toList();
  }

  @override
  List<ProductEntity> fetchProducts() {
    var productsBox = Hive.box<ProductEntity>(kProductsBox);
    print('products box:$productsBox');
    return productsBox.values.toList();
  }

  @override
  List<FavouritesEntity> fetchFavourites() {
    var favouritesBox = Hive.box<FavouritesEntity>(kFavouritesBox);
    return favouritesBox.values.toList();
  }

  @override
  List<AddToCartEntity> fetchCarts() {
    var cartsBox = Hive.box<AddToCartEntity>(kCartBox);
    return cartsBox.values.toList();
  }

  @override
  List<UserEntity> fetchUserData() {
    var userBox = Hive.box<UserEntity>(kUserBox);
    return userBox.values.toList();
  }
}
