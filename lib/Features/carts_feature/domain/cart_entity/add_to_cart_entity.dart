import 'package:hive/hive.dart';

part 'add_to_cart_entity.g.dart';

@HiveType(typeId: 3)
class AddToCartEntity {
  @HiveField(0)
  final num? id;
  @HiveField(1)
  final dynamic? price;
  @HiveField(2)
  final dynamic? oldPrice;
  @HiveField(3)
  final dynamic? discount;
  @HiveField(4)
  final dynamic? image;
  @HiveField(5)
  final dynamic? name;
  @HiveField(6)
  final dynamic? description;

  AddToCartEntity({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });
}
