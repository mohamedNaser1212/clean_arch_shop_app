import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_title_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_grid_view.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../cubit/categories_cubit/categories_cubit.dart';
import '../cubit/products_cubit/get_product_cubit.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final homeModel = ProductsCubit.get(context).homeModel;
    final categoryModel = CategoriesCubit.get(context).categoriesModel;

    return _body(categoryModel, homeModel);
  }

  SingleChildScrollView _body(
      List<CategoriesEntity>? categoryModel, List<ProductEntity>? homeModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const CategoriesTitleWidget(),
          const SizedBox(height: 10),
          if (categoryModel != null)
            const CustomCategoriesListView(
              isHorizontal: true,
              itemHeight: 100.0,
              itemWidth: 100.0,
            )
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
    );
  }
}
