import 'package:hive/hive.dart';

part 'add_to_cart_entity.g.dart';

@HiveType(typeId: 3)
class AddToCartEntity {
  @HiveField(0)
  final num? id;
  @HiveField(1)
  final num? price;
  @HiveField(2)
  final num? oldPrice;
  @HiveField(3)
  final num? discount;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final String? name;
  @HiveField(6)
  final String? description;

  AddToCartEntity({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  factory AddToCartEntity.fromJson(Map<String, dynamic> json) {
    return AddToCartEntity(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      description: json['description'],
      name: json['name'],
    );
  }
}
