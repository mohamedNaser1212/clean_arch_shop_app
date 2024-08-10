import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';

import '../core/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopToggleFavoriteSuccessState) {
          Fluttertoast.showToast(
            msg: state.isFavourite.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor:
                state.isFavourite.status! ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        final homeModel = ShopCubit.get(context).homeModel;
        final categoryModel = ShopCubit.get(context).categoriesModel;
        final cartModel = ShopCubit.get(context).cartModel;

        if (homeModel == null || categoryModel == null) {
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Colors.white,
              size: 120,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                ConditionalBuilder(
                  condition: ShopCubit.get(context).categoriesModel != null,
                  builder: (context) {
                    return buildCategoriesListView(categoryModel, context);
                  },
                  fallback: (context) =>
                      const Center(child: Text('Loading...')),
                ),
                const SizedBox(height: 10),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Container(
                  color: Colors.grey[400],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.90,
                    children: List.generate(
                      homeModel.length,
                      (index) => ProductItem(
                        product: homeModel[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoriesListView(
      List<CategoriesEntity> categoryModel, BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            categoryItem(categoryModel[index], context),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: categoryModel.length,
      ),
    );
  }

  Widget categoryItem(CategoriesEntity category, BuildContext context) {
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
}
