import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class HorizontalCategoriesListView extends StatelessWidget {
  const HorizontalCategoriesListView({
    super.key,
    required this.state,
    required this.categoryModel,
  });

  final CategoriesScreenBodyState state;
  final List<CategoriesEntity> categoryModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: state.widget.itemHeight + 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryModel.length,
          itemBuilder: (context, index) {
            var category = categoryModel[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: state.widget.itemWidth / 2,
                    backgroundImage: NetworkImage(category.image),
                  ),
                  const SizedBox(height: 20),
                  CustomTitle(
                    title: category.name,
                    style: TitleStyle.styleBold18,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
