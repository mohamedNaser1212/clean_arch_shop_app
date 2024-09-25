import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'categories_content.dart';

class CategoriesPageItems extends StatelessWidget {
  const CategoriesPageItems(
      {super.key,
      required this.item,
      required this.context,
      required this.state,});
  final CategoriesEntity item;
  final BuildContext context;
final CustomCategoriesListViewState state;


  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Padding _builder() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width:state.widget. itemWidth,
      height:state.widget.  itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepOrange[100],
      ),
      child: CategoriesContents(
        item: item,
        state: state
      ),
    ),
  );
  }
}
