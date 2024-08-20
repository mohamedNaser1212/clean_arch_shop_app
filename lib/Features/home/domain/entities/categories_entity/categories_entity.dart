import 'package:hive/hive.dart';

part 'categories_entity.g.dart';

@HiveType(typeId: 1)
class CategoriesEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;

  const CategoriesEntity({
    required this.name,
    required this.image,
  });

  factory CategoriesEntity.fromJson(Map<String, dynamic> json) {
    return CategoriesEntity(
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
