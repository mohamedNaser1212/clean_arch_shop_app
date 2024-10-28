import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'categories_content.dart';

class CategoriesScreenItemsWidget extends StatelessWidget {
  const CategoriesScreenItemsWidget({
    super.key,
    required this.item,
    required this.state,
  });
  final CategoriesEntity item;
  final CategoriesBodyState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: state.widget.itemWidth,
        height: state.widget.itemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange[100],
        ),
        child: CategoriesItemWidgetBody(item: item, state: state),
      ),
    );
  }
}
