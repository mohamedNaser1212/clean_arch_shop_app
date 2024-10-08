import 'package:hive/hive.dart';

import '../../../../core/models/base_products_model.dart';

part 'add_to_cart_entity.g.dart';

@HiveType(typeId: 3)
class CartEntity extends BaseProductModel {
  const CartEntity({
    @HiveField(0) required super.id,
    @HiveField(1) required super.price,
    @HiveField(2) required super.oldPrice,
    @HiveField(3) required super.discount,
    @HiveField(4) required super.image,
    @HiveField(5) required super.name,
    @HiveField(6) required super.description,
  });
}
