import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_content_body.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';

class CategoriesItemWidgetBody extends StatelessWidget {
  const CategoriesItemWidgetBody({
    super.key,
    required this.item,
    required this.state,
  });
  final CategoriesEntity item;
  final CategoriesBodyState state;

  @override
  Widget build(BuildContext context) {
    return CategoriesContentsBody(
      state: state,
      item: item,
    );
  }
}
