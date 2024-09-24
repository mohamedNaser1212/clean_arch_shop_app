import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class HorizontalCategoriesListView extends StatelessWidget {
  const HorizontalCategoriesListView({
    super.key,
    required this.itemHeight,
    required this.categoryModel,
    required this.itemWidth,
  });

  final double itemHeight;
  final List<CategoriesEntity> categoryModel;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight + 50,
      child: _listView(),
    );
  }

  ListView _listView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryModel.length,
      itemBuilder: (context, index) {
        var category = categoryModel[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: itemWidth / 2,
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
    );
  }
}
