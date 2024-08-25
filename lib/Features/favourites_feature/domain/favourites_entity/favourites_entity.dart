import 'package:hive/hive.dart';

import '../../../../core/models/base_products_model.dart';

part 'favourites_entity.g.dart';

@HiveType(typeId: 2)
class FavouritesEntity extends BaseProductModel {
  const FavouritesEntity({
    @HiveField(0) required super.id,
    @HiveField(1) required super.price,
    @HiveField(2) required super.oldPrice,
    @HiveField(3) required super.discount,
    @HiveField(4) required super.image,
    @HiveField(5) required super.name,
    @HiveField(6) required super.description,
  });
}
