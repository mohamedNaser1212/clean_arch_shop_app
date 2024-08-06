import '../Features/home/domain/entities/categories_entity/categories_entity.dart';

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
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel extends CategoriesEntity {
  num? id;

  DataModel({
    required this.id,
    required String name,
    required String image,
  }) : super(name: name, image: image);

  DataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        super(name: json['name'], image: json['image']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
