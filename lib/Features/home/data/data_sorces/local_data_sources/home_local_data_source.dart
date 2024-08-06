import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';

import '../../../../../core/widgets/end_points.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class HomeLocalDataSource {
  List<ProductEntity> fetchProducts();
  List<CategoriesEntity> fetchCategories();
  List<FavouritesEntity> fetchFavourites();
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
}
