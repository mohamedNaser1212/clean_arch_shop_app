import 'package:flutter/material.dart';

import '../../Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'category_item.dart';

Widget categoriesItemBuilder(List<CategoriesEntity> categoryModel,
    BuildContext context, double itemHeight, double itemWidth) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: itemHeight * 7,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => categoryItem(
                  categoryModel[index], context, itemHeight, itemWidth),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: categoryModel.length,
            ),
          ),
        ],
      ),
    ),
  );
}
