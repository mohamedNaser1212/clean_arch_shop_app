import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_title_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/new_products_text_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_grid_view.dart';
import '../cubit/get_home_data_cubit/get_home_data_cubit.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = GetHomeDataCubit.get(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const CategoriesTitleWidget(),
          const SizedBox(height: 10),
          FutureBuilder(
            future: cubit.getCategoriesData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.connectionState == ConnectionState.done) {
                return CategoriesScreenBody(
                  isHorizontal: true,
                  itemHeight: 100.0,
                  itemWidth: 100.0,
                );
              }else{
                return const SizedBox.shrink();       
              }
            },
          ),
          const SizedBox(height: 20),
          const NewProductsTextWidget(),
          const SizedBox(height: 10),
          FutureBuilder(
            future: cubit.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Failed to load products: ${snapshot.error}'),
                );
              } else {
                return ProductsGridView(
                  products: cubit.homeModel,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
