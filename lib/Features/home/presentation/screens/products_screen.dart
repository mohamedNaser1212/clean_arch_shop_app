import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: _listener,
      builder: (context, state) => _buildProductsScreen(context, state),
    );
  }
}

void _listener(BuildContext context, ShopStates state) {
  if (state is ShopToggleFavoriteSuccessState) {
    showToast(message: state.isFavourite.message!, isError: false);
  } else if (state is ShopToggleFavoriteErrorState) {
    showToast(message: state.error, isError: true);
  } else if (state is ShopChangeCartSuccessState) {
    if (state.model == true) {
      showToast(message: 'Item added to cart successfully', isError: false);
    } else {
      showToast(message: 'Item removed from cart successfully', isError: false);
    }
  } else if (state is ShopChangeFavoriteSuccessState) {
    if (state.isFavourite == true) {
      showToast(
          message: 'Item added to favourite successfully', isError: false);
    } else {
      showToast(
          message: 'Item removed from favourite successfully', isError: false);
    }
  }
}

Widget _buildProductsScreen(BuildContext context, ShopStates state) {
  final homeModel = ShopCubit.get(context).homeModel;
  final categoryModel = ShopCubit.get(context).categoriesModel;

  if (homeModel == null || categoryModel == null) {
    return const LoadingIndicatorWidget();
  }

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTitle(
            title: 'Categories',
            fontSize: 24,
            color: ColorController.blackColor,
            fontWeight: FontWeight.w900,
          ),
          const SizedBox(height: 10),
          CategoriesSection(categories: categoryModel),
          const SizedBox(height: 10),
          const CustomTitle(
            title: 'New Products',
            fontSize: 24,
            color: ColorController.blackColor,
            fontWeight: FontWeight.w900,
          ),
          ProductsGridView(products: homeModel),
        ],
      ),
    ),
  );
}
