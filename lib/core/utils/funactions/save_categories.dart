import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';

void saveCategoriesData(List<CategoriesEntity> categories, String boxName) {
  var box = Hive.box<CategoriesEntity>(boxName);
  box.addAll(categories);
  print('categories box:$box');
}
