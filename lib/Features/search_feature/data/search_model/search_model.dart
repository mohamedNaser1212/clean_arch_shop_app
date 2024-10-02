import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

class SearchModel extends BaseProductModel {
  const SearchModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.description,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json[RequestDataNames.id],
      price: json[RequestDataNames.price] ?? 0,
      oldPrice: json[RequestDataNames.oldPrice] ?? 0,
      discount: json[RequestDataNames.discount] ?? 0,
      image: json[RequestDataNames.image],
      name: json[RequestDataNames.name],
      description: json[RequestDataNames.description],
    );
  }
}
