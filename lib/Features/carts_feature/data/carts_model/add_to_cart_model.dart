import 'cart_data_list.dart';

class AddToCartModel {
  final bool? status;
  final String? message;
  final CartData? data;

  const AddToCartModel({this.status, this.message, this.data});

  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    return AddToCartModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
