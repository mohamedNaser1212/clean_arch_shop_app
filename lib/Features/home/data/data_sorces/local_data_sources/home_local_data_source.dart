import 'package:hive/hive.dart';

import '../../../../../core/widgets/end_points.dart';
import '../../../../../models/categories_model.dart';
import '../../../../../models/home_model.dart';

abstract class HomeLocalDataSource {
  List<ProductModel> fetchProducts();
  List<DataModel> fetchCategories();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<DataModel> fetchCategories() {
    var CategoriesBox=Hive.box<DataModel>(kCategoriesBox);
    return CategoriesBox.values.toList();
  }

  @override
  List<ProductModel> fetchProducts() {

    var productsBox=Hive.box<ProductModel>(kProductsBox);
    return productsBox.values.toList();

  }

}