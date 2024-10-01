import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/horizontal_categories_list_view.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/vertical_categories_list_view.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class CategoriesScreenBody extends StatefulWidget {
  const CategoriesScreenBody({
    super.key,
    this.itemHeight = 150.0,
    this.itemWidth = 150.0,
    required this.isHorizontal,
  });

  final double itemHeight;
  final double itemWidth;
  final bool isHorizontal;

  @override
  State<CategoriesScreenBody> createState() => CategoriesScreenBodyState();
}

class CategoriesScreenBodyState extends State<CategoriesScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(context, state) {}

  Widget _builder(context, state) {
    return ConditionalBuilder(
      condition: CategoriesCubit.get(context).categoriesModel != null,
      builder: (context) {
        var categoryModel = CategoriesCubit.get(context).categoriesModel;

        return widget.isHorizontal
            ? HorizontalCategoriesListView(
                state: this,
                categoryModel: categoryModel!,
              )
            : VerticalCategoriesListView(
                categoryModel: categoryModel!,
                state: this,
              );
      },
      fallback: (context) => const Center(
        child: CustomTitle(
          title: 'Loading...',
          style: TitleStyle.styleBold18,
        ),
      ),
    );
  }
}
