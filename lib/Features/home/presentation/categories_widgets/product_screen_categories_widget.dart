import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_progress_indicator.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'categories_list_view.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoriesEntity> categories;

  const CategoriesSection({required this.categories, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: categories.isNotEmpty,
      builder: (context) => CategoriesListView(
        categoryModel: categories,
        itemHeight: MediaQuery.of(context).size.height * 0.2,
        itemWidth: MediaQuery.of(context).size.width * 0.3,
      ),
      fallback: (context) => const Center(child: Text('Loading...')),
    );


  }
}
