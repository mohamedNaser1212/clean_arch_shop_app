import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

abstract class BaseProductModel {
  final num id;
  final num price;
  final num oldPrice;
  final num discount;
  final String image;
  final List<String>? images;
  final String name;
  final String description;

  const BaseProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
     this.images,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
    RequestDataNames.id: id,
      RequestDataNames.price: price,
       RequestDataNames.oldPrice: oldPrice,
       RequestDataNames.discount: discount,
       RequestDataNames.image: image,
       RequestDataNames.images: images,
       RequestDataNames.name: name,
       RequestDataNames.description: description,
    };
  }
}
