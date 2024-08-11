import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';

import '../Features/home/domain/entities/products_entity/product_entity.dart';
import '../core/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopToggleFavoriteSuccessState) {
          _showToast(state.isFavourite.message!, state.isFavourite.status!);
        } else if (state is ShopChangeCartSuccessState) {
          _showToast('Item added to cart', true);
        }
      },
      builder: (context, state) {
        final homeModel = ShopCubit.get(context).homeModel;
        final categoryModel = ShopCubit.get(context).categoriesModel;

        if (homeModel == null || categoryModel == null) {
          return _buildLoadingIndicator();
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Categories'),
                const SizedBox(height: 10),
                _buildCategoriesSection(context, categoryModel),
                const SizedBox(height: 10),
                _buildSectionTitle('New Products'),
                _buildProductsGrid(homeModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: LoadingAnimationWidget.waveDots(
        color: Colors.white,
        size: 120,
      ),
    );
  }

  void _showToast(String message, bool success) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: success ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildCategoriesSection(
      BuildContext context, List<CategoriesEntity> categories) {
    return ConditionalBuilder(
      condition: categories.isNotEmpty,
      builder: (context) => _buildCategoriesListView(categories),
      fallback: (context) => const Center(child: Text('Loading...')),
    );
  }

  Widget _buildCategoriesListView(List<CategoriesEntity> categories) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildCategoryItem(categories[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: categories.length,
      ),
    );
  }

  Widget _buildCategoryItem(CategoriesEntity category) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider(category.image),
          ),
          const SizedBox(height: 10),
          Text(
            category.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(List<ProductEntity> products) {
    return Container(
      color: Colors.grey[400],
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1 / 1.90,
        children: List.generate(
          products.length,
          (index) => ProductItem(
            product: products[index],
          ),
        ),
      ),
    );
  }
}
