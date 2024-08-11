import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'package:shop_app/screens/products_details_screen.dart';

import '../core/widgets/end_points.dart';
import '../core/widgets/reusable_widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
        var favouritesModel = ShopCubit.get(context).getFavouritesModel;
        if (favouritesModel.isEmpty) {
          return const Center(
            child: Text('Sorry, there are no favourites to show'),
          );
        }
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState &&
              state is! ShopToggleFavoriteLoadingState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildFavItem(context, favouritesModel[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: favouritesModel.length,
          ),
          fallback: (context) => Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
          ),
        );
      },
    );
  }

  Widget buildFavItem(BuildContext context, FavouritesEntity model) {
    var isFavourite = favorites?[model.id!] ?? false;
    var isCart = carts[model.id!] ?? false;
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
                            ShopCubit.get(context).changeFavourite(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                isFavourite ? Colors.red : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     ShopCubit.get(context).toggleCart([model.id!]);
                        //   },
                        //   icon: CircleAvatar(
                        //     backgroundColor: isCart ? Colors.red : Colors.grey,
                        //     radius: 15,
                        //     child: const Icon(
                        //       Icons.add_shopping_cart,
                        //       size: 15,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
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
