import '../Features/home/domain/entities/products_entity/product_entity.dart';

class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  num? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel extends ProductEntity {
  num id;
  num price;
  num oldPrice;
  num discount;
  String image;
  String name;
  bool? inFavorite;
  bool? inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorite,
    required this.inCart,
  }) : super(
          id: id!,
          name: name!,
          discount: discount!,
          oldPrice: oldPrice!,
          price: price!,
          image: image!,
        );

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        inFavorite = json['in_favorites'],
        inCart = json['in_cart'],
        super(
          id: json['id'],
          name: json['name'],
          discount: json['discount'],
          oldPrice: json['old_price'],
          price: json['price'],
          image: json['image'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'in_favorites': inFavorite,
      'in_cart': inCart,
    };
  }
}
