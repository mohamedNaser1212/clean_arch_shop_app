import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_content.dart';

class VerticalCategoriesListView extends StatelessWidget {
  const VerticalCategoriesListView({
    super.key,
    required this.categoryModel,
    required this.itemHeight,
    required this.itemWidth,
  });

  final List<CategoriesEntity> categoryModel;
  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: categoryModel.length,
      itemBuilder: (context, index) {
        var category = categoryModel[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CategoriesContents(
            item: category,
            itemHeight: itemHeight,
            itemWidth: itemWidth,
          ),
        );
      },
    );
  }
}
