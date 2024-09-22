import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_grid_view.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../categories_widgets/product_screen_categories_widget.dart';
import '../cubit/categories_cubit/categories_cubit.dart';
import '../cubit/products_cubit/get_product_cubit.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final homeModel = ProductsCubit.get(context).homeModel;
    final categoryModel = CategoriesCubit.get(context).categoriesModel;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(
              title: 'Categories',
              style: TitleStyle.style24,
              color: ColorController.blackColor,
            ),
            const SizedBox(height: 10),
            if (categoryModel != null)
              CategoriesSection(categories: categoryModel)
            else
              const Text('No categories available'),
            const SizedBox(height: 10),
            const CustomTitle(
              title: 'New Products',
              style: TitleStyle.style24,
              color: ColorController.blackColor,
            ),
            if (homeModel != null)
              ProductsGridView(products: homeModel)
            else
              const Text('No products available'),
          ],
        ),
      ),
    );
  }
}