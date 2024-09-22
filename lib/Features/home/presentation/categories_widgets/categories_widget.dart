import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_content.dart';
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
                ? SizedBox(
                    height: itemHeight + 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryModel!.length,
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
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: categoryModel!.length,
                    itemBuilder: (context, index) {
                      var category = categoryModel[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CategoriesContents(
                          item: category,
                          itemHeight: itemHeight,
                          itemWidth: itemWidth,
                        ),
                      );
                    },
                  );
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
