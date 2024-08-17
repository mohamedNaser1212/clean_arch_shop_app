import 'package:hive/hive.dart';

import '../../../Features/home/domain/entities/products_entity/product_entity.dart';

void saveProductsData(List<ProductEntity> products, String boxName) {
  var box = Hive.box<ProductEntity>(boxName);
  box.clear();
  box.addAll(products);
}

Future<List<ProductEntity>> loadProducts(String boxName) async {
  var box = await Hive.openBox<ProductEntity>(boxName);
  return box.values.toList();
}
