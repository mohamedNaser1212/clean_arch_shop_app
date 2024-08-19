import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_state.dart';

import '../../../../core/utils/screens/widgets/custom_title.dart';
import '../../../../core/utils/screens/widgets/loading_indicator.dart';
import '../../../../core/utils/screens/widgets/toast_widget.dart';
import '../../../../core/utils/styles/color_manager.dart';
import '../categories_list_view/product_screen_categories_widget.dart';
import '../products_widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = CategoriesCubit.get(context);
    if (categoriesCubit.categoriesModel == null) {
      categoriesCubit.getCategoriesData();
    }

    final shopCubit = ShopCubit.get(context);
    if (shopCubit.homeModel == null) {
      shopCubit.getProductsData();
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
          return BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, ShopStates shopState) {},
            builder: (context, shopState) {
              if (shopState is ShopLoadingHomeDataState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (shopState is ShopSuccessHomeDataState ||
                  shopCubit.homeModel != null) {
                return _buildProductsScreen(context);
              } else if (shopState is ShopErrorHomeDataState) {
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
    final homeModel = ShopCubit.get(context).homeModel;
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
