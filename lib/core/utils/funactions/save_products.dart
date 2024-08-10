import 'package:hive/hive.dart';

import '../../../models/new_get_home_data.dart';

void saveproductsData(List<Products> products, String boxName) {
  var box = Hive.box<Products>(boxName);
  box.addAll(products);
}
