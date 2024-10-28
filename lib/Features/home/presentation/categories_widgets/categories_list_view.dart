import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import 'category_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required this.categoryModel,
    required this.state,
  });
  final List<CategoriesEntity> categoryModel;
  final CategoriesScreenBodyState state;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: state.widget.itemHeight! * 7,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => CategoriesScreenItemsWidget(
            state: state,
            item: categoryModel[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: categoryModel.length,
        ));
  }
}
