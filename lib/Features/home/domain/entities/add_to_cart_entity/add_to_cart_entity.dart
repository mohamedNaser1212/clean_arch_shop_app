import 'package:hive/hive.dart';

part 'add_to_cart_entity.g.dart';

@HiveType(typeId: 3)
class AddToCartEntity {
  @HiveField(0)
  final dynamic id;
  @HiveField(1)
  final dynamic name;
  @HiveField(2)
  final dynamic price;
  @HiveField(3)
  final dynamic image;
  @HiveField(4)
  final dynamic quantity;
  @HiveField(5)
  final dynamic description;
  @HiveField(6)
  final dynamic oldPrice;

  AddToCartEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.description,
    required this.oldPrice,
  });

  factory AddToCartEntity.fromJson(Map<String, dynamic> json) {
    return AddToCartEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'],
      image: json['image'] ?? '',
      quantity: json['quantity'],
      description: json['description'] ?? 'No description available',
      oldPrice: json['old_price'],
    );
  }
}
