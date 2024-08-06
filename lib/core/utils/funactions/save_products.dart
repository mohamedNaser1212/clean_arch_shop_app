import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';

void saveproductsData(List<ProductEntity> products, String boxName) {
  var box = Hive.box<ProductEntity>(boxName);
  box.addAll(products);
}
