import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../categories_list_view/product_screen_categories_widget.dart';
import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';
import '../products_widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state is CategoriesError) {
              showToast(message: state.error, isError: true);
            }
          },
        ),
      ],
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, categoriesState) {
          return _buildCategoriesSection(context, categoriesState);
        },
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, CategoriesState state) {
    final categoriesCubit = CategoriesCubit.get(context);

    if (state is CategoriesError) {
      return Center(child: Text(state.error));
    } else if (state is CategoriesSuccess ||
        categoriesCubit.categoriesModel != null) {
      return BlocBuilder<ProductsCubit, GetProductsState>(
        builder: (context, productsState) {
          return _buildProductsSection(context, productsState);
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildProductsSection(BuildContext context, GetProductsState state) {
    final productsCubit = ProductsCubit.get(context);

    if (state is GetProductsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GetProductsErrorState) {
      return Center(
        child: CustomTitle(
          title: ' ${state.error ?? 'Oops, please try again later'}',
          style: TitleStyle.style16,
        ),
      );
    } else if (state is GetproductsSuccessState ||
        productsCubit.homeModel != null) {
      return _buildProductsScreenContent(context);
    } else {
      return const Center(child: Text('No products available'));
    }
  }

  Widget _buildProductsScreenContent(BuildContext context) {
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
