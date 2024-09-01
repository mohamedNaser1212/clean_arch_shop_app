import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/toast_function.dart';
import '../categories_list_view/product_screen_categories_widget.dart';
import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';
import '../products_widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = CategoriesCubit.get(context);
    final productsCubit = ProductsCubit.get(context);

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, categoriesState) {
        if (categoriesState is CategoriesError) {
          showToast(message: categoriesState.error, isError: true);
        }
      },
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesSuccess ||
            categoriesCubit.categoriesModel != null) {
          return BlocConsumer<ProductsCubit, GetProductsState>(
            listener: (context, productsState) {
              if (productsState is GetProductsErrorState) {
                showToast(message: productsState.error!, isError: true);
              }
            },
            builder: (context, productsState) {
              if (productsState is GetProductsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (productsState is GetProductsErrorState) {
                return Center(child: Text(' ${productsState.error}'));
              } else if (productsState is GetproductsSuccessState ||
                  productsCubit.homeModel != null) {
                return _buildProductsScreen(context);
              } else {
                return const Center(child: Text('No products available'));
              }
            },
          );
        } else if (categoriesState is CategoriesError) {
          return Center(
              child:
                  Text('Failed to load categories: ${categoriesState.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildProductsScreen(BuildContext context) {
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
