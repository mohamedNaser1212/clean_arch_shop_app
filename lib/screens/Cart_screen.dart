// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
// import 'package:shop_app/core/widgets/end_points.dart';
// import 'package:shop_app/screens/products_details_screen.dart';
//
// import '../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
// import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
// import '../core/widgets/reusable_widgets.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit, ShopStates>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cartModel = ShopCubit.get(context).cartModel;
//         if (cartModel!.isEmpty) {
//           return const Center(
//             child: Text('Sorry, there are no items in the cart'),
//           );
//         }
//
//         return ConditionalBuilder(
//           condition: state is! ShopGetCartItemsLoadingState &&
//               state is! ShopChangeCartItemsLoadingState,
//           builder: (context) => ListView.separated(
//             itemBuilder: (context, index) =>
//                 buildCartItem(context, cartModel[index]),
//             separatorBuilder: (context, index) => const Divider(),
//             itemCount: cartModel.length,
//           ),
//           fallback: (context) => Center(
//             child:
//                 LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildCartItem(BuildContext context, AddToCartEntity model) {
//     var cartItem = carts[model.id] ?? false;
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: InkWell(
//         onTap: () {
//           navigateTo(
//             context: context,
//             screen: ProductsDetailsScreen(
//               model: model,
//             ),
//           );
//         },
//         child: SizedBox(
//           height: 120,
//           child: Row(
//             children: [
//               Stack(
//                 alignment: AlignmentDirectional.bottomStart,
//                 children: [
//                   CachedNetworkImage(
//                     imageUrl: model.image ?? '',
//                     fit: BoxFit.cover,
//                     width: 120,
//                     height: 120,
//                     placeholder: (context, url) => Center(
//                       child: CircularProgressIndicator(
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => const Icon(
//                       Icons.error,
//                       color: Colors.red,
//                     ),
//                   ),
//                   if (model.discount != 0)
//                     Container(
//                       color: Theme.of(context).primaryColor,
//                       padding: const EdgeInsets.all(2),
//                       child: const Text(
//                         'DISCOUNT',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       model.name ?? 'Unknown',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 3),
//                     Row(
//                       children: [
//                         Text(
//                           '${model.price?.round() ?? 0}',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         if (model.discount != 0)
//                           Text(
//                             '\$${model.oldPrice?.round() ?? 0}',
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               decoration: TextDecoration.lineThrough,
//                               color: Colors.grey,
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 3),
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             ShopCubit.get(context).changeCarts(model.id!);
//                           },
//                           icon: CircleAvatar(
//                             backgroundColor:
//                                 cartItem ? Colors.red : Colors.grey,
//                             radius: 15,
//                             child: const Icon(
//                               Icons.add_shopping_cart,
//                               size: 15,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/screens/products_details_screen.dart';

import '../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import '../core/widgets/reusable_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cartModel = ShopCubit.get(context).cartModel;
        var subtotal = ShopCubit.get(context).cartSubtotal;
        var total = ShopCubit.get(context).cartTotal;

        if (cartModel == null || cartModel.isEmpty) {
          return const Center(
            child: Text('Sorry, there are no items in the cart'),
          );
        }

        return ConditionalBuilder(
          condition: state is! ShopGetCartItemsLoadingState &&
              state is! ShopChangeCartItemsLoadingState,
          builder: (context) => Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildCartItem(context, cartModel[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cartModel.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subtotal: \$${subtotal?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: \$${total?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          fallback: (context) => Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
          ),
        );
      },
    );
  }

  Widget buildCartItem(BuildContext context, AddToCartEntity model) {
    var cartItem = carts[model.id] ?? false;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(
            context: context,
            screen: ProductsDetailsScreen(
              model: model,
            ),
          );
        },
        child: SizedBox(
          height: 120,
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
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
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
                    Text(
                      model.name ?? 'Unknown',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          '${model.price?.round() ?? 0}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (model.discount != 0)
                          Text(
                            '\$${model.oldPrice?.round() ?? 0}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeCarts(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                cartItem ? Colors.red : Colors.grey,
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
