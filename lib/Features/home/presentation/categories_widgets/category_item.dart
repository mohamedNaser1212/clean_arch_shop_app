import 'package:flutter/material.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'categories_content.dart';

class CategoriesPageItems extends StatelessWidget {
  const CategoriesPageItems(
      {super.key,
      required this.item,
      required this.context,
      required this.itemHeight,
      required this.itemWidth});
  final CategoriesEntity item;
  final BuildContext context;
  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Padding _builder() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: itemWidth,
      height: itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepOrange[100],
      ),
      child: CategoriesContents(
        item: item,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
      ),
    ),
  );
  }
}
