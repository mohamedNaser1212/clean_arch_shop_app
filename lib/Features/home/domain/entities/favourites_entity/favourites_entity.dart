import 'package:hive/hive.dart';

part 'favourites_entity.g.dart';

@HiveType(typeId: 2)
class FavouritesEntity {
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

  FavouritesEntity({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
  });

  factory FavouritesEntity.fromJson(Map<String, dynamic> json) {
    return FavouritesEntity(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
    );
  }
}
