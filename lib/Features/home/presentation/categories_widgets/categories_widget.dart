import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_content.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/horizontal_categories_list_view.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/vertical_categories_list_view.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class CustomCategoriesListView extends StatelessWidget {
  const CustomCategoriesListView({
    super.key,
    this.itemHeight = 150.0,
    this.itemWidth = 150.0,
    required this.isHorizontal,
  });

  final double itemHeight;
  final double itemWidth;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CategoriesCubit.get(context).categoriesModel != null,
          builder: (context) {
            var categoryModel = CategoriesCubit.get(context).categoriesModel;

            return isHorizontal
                ? HorizontalCategoriesListView(
                    itemHeight: itemHeight,
                    categoryModel: categoryModel!,
                    itemWidth: itemWidth)
                : VerticalCategoriesListView(
                    categoryModel: categoryModel!,
                    itemHeight: itemHeight,
                    itemWidth: itemWidth);
          },
          fallback: (context) => const Center(
            child: CustomTitle(
              title: 'Loading...',
              style: TitleStyle.styleBold18,
            ),
          ),
        );
      },
    );
  }
}


