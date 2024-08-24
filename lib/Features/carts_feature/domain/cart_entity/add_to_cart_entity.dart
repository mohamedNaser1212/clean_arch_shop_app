import 'package:hive/hive.dart';

part 'add_to_cart_entity.g.dart';

@HiveType(typeId: 3)
class AddToCartEntity {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final num price;
  @HiveField(2)
  final num oldPrice;
  @HiveField(3)
  final num discount;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final String description;

  const AddToCartEntity({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
}
