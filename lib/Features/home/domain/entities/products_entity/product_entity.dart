import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final num discount;
  @HiveField(3)
  final num price;
  @HiveField(4)
  final num oldPrice;
  @HiveField(5)
  final String image;

  ProductEntity({
    required this.id,
    required this.name,
    required this.discount,
    required this.oldPrice,
    required this.price,
    required this.image,
  });
}
