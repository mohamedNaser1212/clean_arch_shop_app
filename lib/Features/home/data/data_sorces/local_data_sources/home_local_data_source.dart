import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';

import '../../../../../core/widgets/end_points.dart';

abstract class HomeLocalDataSource {
  // List<Products> fetchProducts();
  List<CategoriesEntity> fetchCategories();
  List<FavouritesEntity> fetchFavourites();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<CategoriesEntity> fetchCategories() {
    var categoriesBox = Hive.box<CategoriesEntity>(kCategoriesBox);
    return categoriesBox.values.toList();
  }

  // @override
  // List<Products> fetchProducts() {
  //   var productsBox = Hive.box<Products>(kProductsBox);
  //   print('products box:$productsBox');
  //   return productsBox.values.toList();
  // }

  @override
  List<FavouritesEntity> fetchFavourites() {
    var favouritesBox = Hive.box<FavouritesEntity>(kFavouritesBox);
    return favouritesBox.values.toList();
  }
}
