import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';
import 'categories_list_view.dart';

class CategoriesItemBuilder extends StatelessWidget {
  const CategoriesItemBuilder(
      {super.key,
      required this.categoryModel,
      required this.context,
      required this.itemHeight,
      required this.itemWidth});
  final List<CategoriesEntity> categoryModel;

  final BuildContext context;
  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(
              title: 'Categories',
              style: TitleStyle.style24,
              color: ColorController.blackColor,
            ),
            const SizedBox(height: 10),
            CategoriesListView(
              categoryModel: categoryModel,
              itemHeight: itemHeight,
              itemWidth: itemWidth,
            ),
          ],
        ),
      ),
    );
  }
}
