import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';

class NewGetHomeData {
  NewGetHomeData({
    this.status,
    this.message,
    this.data,
  });

  factory NewGetHomeData.fromJson(dynamic json) {
    return NewGetHomeData(
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

class Data {
  const Data({
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

  factory Data.fromJson(dynamic json) {
    return Data(
      currentPage: json['current_page'],
      data: List<Products>.from(json['data'].map((x) => Products.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
    );
  }
  final num? currentPage;
  final List<Products>? data;
  final String? firstPageUrl;
  final num? from;
  final num? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final num? perPage;
  final dynamic prevPageUrl;
  final num? to;
  final num? total;

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
  final String description;
  final bool inFavorites;
  final bool? inCart;

  Products({
    required this.description,
    required this.inFavorites,
    this.inCart,
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

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      description: json['description'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
      id: json['id'],
      name: json['name'],
      discount: json['discount'],
      price: json['price'],
      oldPrice: json['old_price'],
      image: json['image'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    map['id'] = id;
    map['name'] = name;
    map['discount'] = discount;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['image'] = image;
    map['images'] = images;
    return map;
  }
}
