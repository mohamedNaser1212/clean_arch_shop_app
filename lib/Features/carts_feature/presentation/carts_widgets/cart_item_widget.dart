import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';

import '../../../../../core/widgets/end_points.dart';
import '../../../../core/utils/color_controllers/color_controller.dart';
import '../../../../core/utils/screens/products_details_screen.dart';
import '../../../home/presentation/cubit/shop_cubit/shop_cubit.dart';
import '../../../home/presentation/products_widgets/products_information_widget.dart';
import '../../domain/add_to_cart_entity/add_to_cart_entity.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartEntity model;

  const CartItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var cartItem = carts[model.id] ?? false;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(
            context: context,
            screen: ProductsDetailsScreen(model: model),
          );
        },
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.image ?? '',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(2),
                      child: const CustomTitle(
                        title: 'DISCOUNT',
                        fontSize: 12,
                        color: ColorController.warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductInformationWidget(product: model),
                    const SizedBox(height: 3),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeCarts(model.id!);
                      },
                      icon: CircleAvatar(
                        backgroundColor: cartItem ? Colors.red : Colors.grey,
                        radius: 15,
                        child: const Icon(
                          Icons.add_shopping_cart,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
