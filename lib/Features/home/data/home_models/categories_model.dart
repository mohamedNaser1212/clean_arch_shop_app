import '../../domain/entities/categories_entity/categories_entity.dart';

class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  num? currentPage;
  List<CategoriesData> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(CategoriesData.fromJson(element));
    });
  }
}

class CategoriesData extends CategoriesEntity {
  final num? id;

  const CategoriesData({
    required this.id,
    required String name,
    required String image,
  }) : super(name: name, image: image);

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
