import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';

void saveCategoriesData(List<CategoriesEntity> categories, String boxName) {
  var box = Hive.box<CategoriesEntity>(boxName);
  box.clear(); // Clear the box before adding new data
  box.addAll(categories);
  print('categories box:$box');
}

Future<List<CategoriesEntity>> loadCategories(String boxName) async {
  var box = await Hive.openBox<CategoriesEntity>(boxName);
  return box.values.toList();
}
