import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';

import '../../../../core/managers/reusable_widgets_manager/toast_widget.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../../core/utils/widgets/loading_indicator.dart';
import '../categories_list_view/product_screen_categories_widget.dart';
import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';
import '../products_widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = CategoriesCubit.get(context);
    if (categoriesCubit.categoriesModel == null) {
      categoriesCubit.getCategoriesData();
    }

    final shopCubit = GetProductsCubit.get(context);
    if (shopCubit.homeModel == null) {
      shopCubit.getProductsData(context: context);
    }

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, CategoriesState categoriesState) {
        if (categoriesState is CategoriesError) {
          showToast(message: categoriesState.error, isError: true);
        }
      },
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesLoading) {
          return const LoadingIndicatorWidget();
        } else if (categoriesState is CategoriesSuccess ||
            categoriesCubit.categoriesModel != null) {
          return BlocConsumer<GetProductsCubit, GetProductsState>(
            listener: (context, GetProductsState shopState) {},
            builder: (context, shopState) {
              if (shopState is GetProductsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (shopState is GetproductsSuccessState ||
                  shopCubit.homeModel != null) {
                return _buildProductsScreen(context);
              } else if (shopState is GetProductsErrorState) {
                return Center(
                  child: Text('Failed to load products: ${shopState.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else if (categoriesState is CategoriesError) {
          return Center(
            child: Text('Failed to load categories: ${categoriesState.error}'),
          );
        } else {
          return const Center(
            child: Text('Unexpected error occurred'),
          );
        }
      },
    );
  }

  Widget _buildProductsScreen(BuildContext context) {
    final homeModel = GetProductsCubit.get(context).homeModel;
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
            CategoriesSection(categories: categoryModel!),
            const SizedBox(height: 10),
            const CustomTitle(
              title: 'New Products',
              style: TitleStyle.style24,
              color: ColorController.blackColor,
            ),
            ProductsGridView(products: homeModel!),
          ],
        ),
      ),
    );
  }
}
