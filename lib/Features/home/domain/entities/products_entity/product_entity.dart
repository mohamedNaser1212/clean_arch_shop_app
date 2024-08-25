import 'package:hive/hive.dart';

import '../../../../../core/models/base_products_model.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends BaseProductModel {
  @HiveField(7)
  final List<String> images;
  @HiveField(8)
  final bool? inFavorites;
  @HiveField(9)
  final bool inCart;

  const ProductEntity({
    @HiveField(0) required super.id,
    @HiveField(1) required super.name,
    @HiveField(2) required super.discount,
    @HiveField(3) required super.price,
    @HiveField(4) required super.oldPrice,
    @HiveField(5) required super.image,
    @HiveField(6) required super.description,
    @HiveField(7) required this.images,
    @HiveField(8) this.inFavorites,
    @HiveField(9) required this.inCart,
  });
}
