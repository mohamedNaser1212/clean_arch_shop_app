import 'categories_data.dart';

class CategoriesModel {
  bool? status;
  CategoriesListModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesListModel.fromJson(json['data']);
  }
}

class CategoriesListModel {
  num? currentPage;
  List<CategoriesData> data = [];

  CategoriesListModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(CategoriesData.fromJson(element));
    });
  }
}
