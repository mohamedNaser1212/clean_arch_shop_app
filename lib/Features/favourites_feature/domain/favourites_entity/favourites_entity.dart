import 'package:hive/hive.dart';

part 'favourites_entity.g.dart';

@HiveType(typeId: 2)
class FavouritesEntity {
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

  const FavouritesEntity({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
}
