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
}
