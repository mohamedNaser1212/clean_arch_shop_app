import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

import '../../../domain/entities/categories_entity/categories_entity.dart';

class CategoryModel extends CategoriesEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json[RequestDataNames.id],
      name: json[RequestDataNames.name],
      image: json[RequestDataNames.image],
    );
  }

  Map<String, dynamic> toJson() {
    return {
     RequestDataNames.id: id,
     RequestDataNames.name: name,
      RequestDataNames.image: image,
    };
  }
}
