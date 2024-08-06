import '../Features/home/domain/entities/favourites_entity/favourites_entity.dart';

class NewFavouritesModel {
  NewFavouritesModel({
    this.status,
    this.message,
    this.data,
  });

  NewFavouritesModel.fromJson(dynamic json) {
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
        data?.add(DataList.fromJson(v));
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
  List<DataList>? data;
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
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
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

class DataList {
  DataList({
    this.id,
    this.product,
  });

  DataList.fromJson(dynamic json) {
    id = json['id'];
    product = json['product'] != null
        ? FavouriteProduct.fromJson(json['product'])
        : null;
  }
  num? id;
  FavouriteProduct? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }
}

class FavouriteProduct extends FavouritesEntity {
  FavouriteProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  }) : super(
          id: id,
          price: price,
          oldPrice: oldPrice,
          discount: discount,
          image: image,
          name: name,
          description: description,
        );

  FavouriteProduct.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    print('FavouriteProduct.fromJson: $json');
    print('FavouriteProduct.fromJson: $description');
  }
  num? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
