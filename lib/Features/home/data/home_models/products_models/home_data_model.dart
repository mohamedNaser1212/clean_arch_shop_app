import '../../../../favourites_feature/data/favourites_models/favourites_model.dart';

class HomeDataModel {
  const HomeDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory HomeDataModel.fromJson(dynamic json) {
    return HomeDataModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
  final bool? status;
  final String? message;
  final Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
