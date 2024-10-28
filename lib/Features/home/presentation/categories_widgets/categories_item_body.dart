import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_title_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'categories_list_view.dart';

class CategoriesItemBody extends StatelessWidget {
  const CategoriesItemBody({
    super.key,
    required this.categoryModel,
    required this.context,
    required this.state,
  });
  final List<CategoriesEntity> categoryModel;

  final BuildContext context;
  final CategoriesBodyState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoriesTitleWidget(),
          const SizedBox(height: 10),
          CategoriesListView(
            categoryModel: categoryModel,
            state: state,
          ),
        ],
      ),
    );
  }
}
