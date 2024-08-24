class SearchProduct {
  final num id;
  final num price;
  final num oldPrice;
  final num discount;
  final String image;
  final String name;
  final String description;

  const SearchProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'] ?? 0,
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }

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
