import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_title_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/empty_categories_text_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/empty_products_text_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/new_products_text_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_grid_view.dart';
import '../cubit/get_categories_cubit/categories_cubit.dart';
import '../cubit/get_products_cubit/get_product_cubit.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final homeModel = ProductsCubit.get(context).homeModel;
    final categoryModel = CategoriesCubit.get(context).categoriesModel;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const CategoriesTitleWidget(),
          const SizedBox(height: 10),
          if (categoryModel != null)
            CategoriesScreenBody(
              isHorizontal: true,
              itemHeight: 100.0,
              itemWidth: 100.0,
            )
          else
            const EmptyCategoriesTextWidget(),
          const SizedBox(height: 10),
          const NewProductsTextWidget(),
          if (homeModel != null)
            ProductsGridView(products: homeModel)
          else
            const EmptyProductsTextWidget(),
        ],
      ),
    );
  }
}
