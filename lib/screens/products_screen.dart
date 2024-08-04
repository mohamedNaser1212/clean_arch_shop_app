import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

import '../Features/home/data/repos/home_repo/home_repo.dart';
import '../Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import '../Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import '../core/utils/funactions/set_up_service_locator.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final fetchProductsUseCase =
            FetchProductsUseCase(getIt.get<HomeRepo>());

        final fetchCategoriesUseCase =
            FetchCategoriesUseCase(getIt.get<HomeRepo>());
        return ShopCubit(fetchProductsUseCase, fetchCategoriesUseCase)
          ..getHomeData()
          ..getCategoriesData();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopChangeFavoritesSuccessState) {
            Fluttertoast.showToast(
              msg: state.model.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: state.model.status! ? Colors.green : Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) {
              var homeModel = ShopCubit.get(context).homeModel;
              var categoryModel = ShopCubit.get(context).categoriesModel;
              return screenBuilder(homeModel!, categoryModel!, context);
            },
            fallback: (context) => const Center(child: Text('Loading...')),
          );
        },
      ),
    );
  }

  Widget screenBuilder(List<ProductModel> homeModel,
      List<DataModel> categoryModel, BuildContext context) {
    List<Widget> banners = homeModel
        .map(
          (e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: banners,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3.5,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Container(
                height: 120,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        categoryItem(categoryModel[index], context),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                    itemCount: categoryModel.length)),
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
                childAspectRatio: 1 / 1.80,
                children: List.generate(
                  homeModel.length,
                  (index) => gridItem(homeModel[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItem(ProductModel product, BuildContext context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${product.image}'),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  if (product.discount != 0)
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
              Text(
                product.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    '${product.price!.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (product.discount != 0)
                    Text(
                      '${product.oldPrice!.round()}',
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
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeFavorites(product.id!);
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 15,
                  child: const Icon(
                    Icons.favorite_border,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget categoryItem(DataModel model, BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text(
              model.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
}

//import 'package:carousel_slider/carousel_slider.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
// import 'package:shop_app/models/categories_model.dart';
// import 'package:shop_app/models/home_model.dart';
//
// import '../Features/home/data/repos/home_repo/home_repo.dart';
// import '../Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
// import '../Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
// import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
// import '../core/utils/funactions/set_up_service_locator.dart';
//
// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key});
//
//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }
//
// class _ProductsScreenState extends State<ProductsScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print('init');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final fetchProductsUseCase =
//             FetchProductsUseCase(getIt.get<HomeRepo>());
//
//         final fetchCategoriesUseCase =
//             FetchCategoriesUseCase(getIt.get<HomeRepo>());
//
//         return ShopCubit(fetchProductsUseCase, fetchCategoriesUseCase)
//           ..getHomeData()
//           ..getCategoriesData();
//       },
//       child: BlocConsumer<ShopCubit, ShopStates>(
//         listener: (context, state) {
//           if (state is ShopChangeFavoritesSuccessState) {
//             Fluttertoast.showToast(
//               msg: state.model.message!,
//               toastLength: Toast.LENGTH_LONG,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 1,
//               backgroundColor: state.model.status! ? Colors.green : Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0,
//             );
//           }
//         },
//         builder: (context, state) {
//           return ConditionalBuilder(
//             condition: state is ShopSuccessHomeDataState,
//             builder: (context) {
//               var homeModel = ShopCubit.get(context).homeModel;
//               var categoryModel = ShopCubit.get(context).categoriesModel;
//               return screenBuilder(homeModel!, categoryModel!, context);
//             },
//             fallback: (context) =>
//                 const Center(child: CircularProgressIndicator()),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget screenBuilder(List<ProductModel> homeModel,
//       List<DataModel> categoryModel, BuildContext context) {
//     List<Widget> banners = homeModel
//         .map(
//           (e) => Image(
//             image: NetworkImage('${e.image}'),
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         )
//         .toList();
//
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 CarouselSlider(
//                   items: banners,
//                   options: CarouselOptions(
//                     height: MediaQuery.of(context).size.height / 3.5,
//                     initialPage: 0,
//                     viewportFraction: 1,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     autoPlayInterval: const Duration(seconds: 3),
//                     autoPlayAnimationDuration: const Duration(seconds: 1),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     scrollDirection: Axis.horizontal,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Categories',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//                 color: Colors.grey[400],
//                 height: MediaQuery.of(context).size.height / 7,
//                 child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) =>
//                         categoryItem(categoryModel[index], context),
//                     separatorBuilder: (context, index) => const SizedBox(
//                           width: 10,
//                         ),
//                     itemCount: categoryModel.length)),
//             const SizedBox(height: 10),
//             const Text(
//               'New Products',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             Container(
//               color: Colors.grey[400],
//               child: GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 1,
//                 crossAxisSpacing: 1,
//                 childAspectRatio: 1 / 1.80,
//                 children: List.generate(
//                   homeModel.length,
//                   (index) => gridItem(homeModel[index], context),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget gridItem(ProductModel product, BuildContext context) => Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: AlignmentDirectional.bottomStart,
//                 children: [
//                   Image(
//                     image: NetworkImage('${product.image}'),
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 4,
//                   ),
//                   if (product.discount != 0)
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
//               Text(
//                 product.name!,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 3),
//               Row(
//                 children: [
//                   Text(
//                     '${product.price!.round()}',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   if (product.discount != 0)
//                     Text(
//                       '${product.oldPrice!.round()}',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         decoration: TextDecoration.lineThrough,
//                         color: Colors.grey,
//                       ),
//                     ),
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {
//                   ShopCubit.get(context).changeFavorites(product.id!);
//                 },
//                 icon: CircleAvatar(
//                   // backgroundColor: ShopCubit.get(context).favorites[product.id]!
//                   //     ? Colors.amber
//                   //     :
//                   //
//                   backgroundColor: Colors.grey,
//                   radius: 15,
//                   child: const Icon(
//                     Icons.favorite_border,
//                     size: 15,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//
//   Widget categoryItem(DataModel model, BuildContext context) =>
//       ConditionalBuilder(
//         condition: model.image != null,
//         builder: (context) => Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               Image(
//                 image: NetworkImage('${model.image}'),
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 model.name!,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         fallback: (context) => Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               const Icon(Icons.error),
//               const SizedBox(height: 5),
//               Text(
//                 model.name!,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }
