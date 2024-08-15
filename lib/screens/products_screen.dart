import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/core/widgets/toast_widget.dart';

import '../core/widgets/categories_list_view/product_screen_categories_widget.dart';
import '../core/widgets/custom_title.dart';
import '../core/widgets/loading_indicator.dart';
import '../core/widgets/products_widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: _listener,
      builder: (context, state) => _buildProductsScreen(context, state),
    );
  }
}

void _listener(BuildContext context, ShopStates state) {
  if (state is ShopToggleFavoriteSuccessState) {
    showToast(message: state.isFavourite.message!, isError: false);
  } else if (state is ShopChangeCartSuccessState) {
    showToast(message: 'Item added to cart', isError: true);
  }
}

Widget _buildProductsScreen(BuildContext context, ShopStates state) {
  final homeModel = ShopCubit.get(context).homeModel;
  final categoryModel = ShopCubit.get(context).categoriesModel;

  if (homeModel == null || categoryModel == null) {
    return LoadingIndicatorWidget();
  }

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(
            title: 'Categories',
            fontSize: 24,
            color: blackColor,
            fontWeight: FontWeight.w900,
          ),
          const SizedBox(height: 10),
          CategoriesSection(categories: categoryModel),
          const SizedBox(height: 10),
          CustomTitle(
            title: 'New Products',
            fontSize: 24,
            color: blackColor,
            fontWeight: FontWeight.w900,
          ),
          ProductsGridView(products: homeModel),
        ],
      ),
    ),
  );
}
