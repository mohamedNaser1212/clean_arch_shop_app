import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_content_body.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';

class CategoriesContents extends StatelessWidget {
  const CategoriesContents(
      {super.key,
      required this.item,
      required this.state,
   });
  final CategoriesEntity item;
  final CustomCategoriesListViewState state;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  CategoriesContentsBody _body() {
    return CategoriesContentsBody(
    state: state  ,
    item: item,
  );
  }
}
