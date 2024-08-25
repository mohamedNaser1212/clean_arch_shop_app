import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/utils/screens/products_details_screen.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../home/presentation/products_widgets/products_information_widget.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

class CartItemWidget extends StatelessWidget {
  final CartEntity model;

  const CartItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var cartItem = CartsCubit.get(context).carts[model.id] ?? false;

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
                        style: TitleStyle.style12,
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
                        CartsCubit.get(context).changeCarts(model.id!);
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
