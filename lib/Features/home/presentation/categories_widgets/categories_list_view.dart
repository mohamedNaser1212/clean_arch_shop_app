import 'package:flutter/cupertino.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'category_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView(
      {super.key,
      required this.categoryModel,
      required this.itemHeight,
      required this.itemWidth});
  final List<CategoriesEntity> categoryModel;
  final double itemHeight;
  final double itemWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight * 7,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => CategoriesPageItems(
          context: context,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          item: categoryModel[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: categoryModel.length,
      ),
    );
  }
}
