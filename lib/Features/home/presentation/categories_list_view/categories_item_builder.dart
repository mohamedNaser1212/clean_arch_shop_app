import 'package:flutter/material.dart';

import '../../../../core/utils/screens/widgets/custom_title.dart';
import '../../../../core/utils/styles/color_manager.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';
import 'category_item.dart';

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
}