import 'package:hive/hive.dart';

import '../../domain/add_to_cart_entity/add_to_cart_entity.dart';

Future<void> saveCarts(List<AddToCartEntity> carts, String boxName) async {
  var box = await Hive.openBox<AddToCartEntity>(boxName);
  await box.clear();
  await box.addAll(carts);
}

Future<List<AddToCartEntity>> loadCarts(String boxName) async {
  var box = await Hive.openBox<AddToCartEntity>(boxName);
  return box.values.toList();
}
