import 'package:hive/hive.dart';

part 'categories_entity.g.dart';

@HiveType(typeId: 1)
class CategoriesEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;

  CategoriesEntity({
    required this.name,
    required this.image,
  });

  // Factory constructor to create a CategoriesEntity from JSON
  factory CategoriesEntity.fromJson(Map<String, dynamic> json) {
    return CategoriesEntity(
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  // Method to convert CategoriesEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
