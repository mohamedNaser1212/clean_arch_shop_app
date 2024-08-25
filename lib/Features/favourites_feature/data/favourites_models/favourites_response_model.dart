import '../../domain/favourites_entity/favourites_entity.dart';

class FavouritesResponseModel extends FavouritesEntity {
  const FavouritesResponseModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.description,
  });

  factory FavouritesResponseModel.fromJson(Map<String, dynamic> json) {
    return FavouritesResponseModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
