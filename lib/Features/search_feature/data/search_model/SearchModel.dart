import 'package:shop_app/Features/search_feature/data/search_model/search_data_list.dart';

class SearchModel {
  bool? status;
  String? message;
  SearchDataList? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = SearchDataList.fromJson(json['data']);
  }
}
