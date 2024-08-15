import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/categories_list_view/product_screen%20categories_list_view.dart';

import '../../../Features/home/domain/entities/categories_entity/categories_entity.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoriesEntity> categories;

  const CategoriesSection({required this.categories, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: categories.isNotEmpty,
      builder: (context) => CategoriesListView(categories: categories),
      fallback: (context) => const Center(child: Text('Loading...')),
    );
  }
}
