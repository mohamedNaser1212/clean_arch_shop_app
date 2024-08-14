import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';

class NewGetHomeData {
  NewGetHomeData({
    this.status,
    this.message,
    this.data,
  });

  NewGetHomeData.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;

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

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Products.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  num? currentPage;
  List<Products>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;

    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

class Products extends ProductEntity {
  Products({
    required this.description,
    required this.inFavorites,
    required this.inCart,
    required num id,
    required num price,
    required num oldPrice,
    required num discount,
    required String image,
    required String name,
    required List<String> images,
  }) : super(
          id: id,
          name: name,
          discount: discount,
          oldPrice: oldPrice,
          price: price,
          image: image,
          images: images,
          description: description,
          inFavorites: inFavorites,
          inCart: inCart!,
        );

  Products.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        inFavorites = json['in_favorites'],
        inCart = json['in_cart'],
        super(
          id: json['id'],
          name: json['name'],
          discount: json['discount'],
          price: json['price'],
          oldPrice: json['old_price'],
          image: json['image'],
          images: List<String>.from(json['images']),
          description: json['description'],
          inFavorites: json['in_favorites'],
          inCart: json['in_cart'],
        );

  String description;
  bool inFavorites;
  bool inCart;
}
