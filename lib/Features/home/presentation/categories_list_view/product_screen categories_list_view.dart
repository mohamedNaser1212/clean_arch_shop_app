import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_list_view/product_screen_categories_item.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';

class CategoriesListView extends StatelessWidget {
  final List<CategoriesEntity> categories;

  const CategoriesListView({required this.categories, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoriesHomeItem(
          category: categories[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: categories.length,
      ),
    );
  }
}
