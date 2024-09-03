import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_information_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/utils/screens/products_details_screen.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../favourites_feature/presentation/favourites_widgets/favourite_and_cart_icons.dart';
import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BaseProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, GetProductsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            NavigationManager.navigateTo(
              context: context,
              screen: ProductsDetailsScreen(model: product),
            );
          },
          child: Container(
            color: ColorController.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: CachedNetworkImageProvider(product.image!),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      if (product.discount != 0)
                        Container(
                          color: ColorController.primaryColor,
                          padding: const EdgeInsets.all(2),
                          child: const CustomTitle(
                            title: 'DISCOUNT',
                            style: TitleStyle.style12,
                            color: ColorController.blackColor,
                          ),
                        ),
                    ],
                  ),
                  ProductInformationWidget(product: product),
                  FavouriteAndCartIcons(product: product),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
