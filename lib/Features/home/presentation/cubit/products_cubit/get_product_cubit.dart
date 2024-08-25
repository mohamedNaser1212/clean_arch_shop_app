import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

import '../../../../carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../domain/entities/products_entity/product_entity.dart';
import '../../../domain/use_case/home_use_case/products_Use_Case.dart';
import 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit({
    required this.fetchHomeItemsUseCase,
  }) : super(ProductsInitialState());

  static GetProductsCubit get(context) => BlocProvider.of(context);

  List<ProductEntity>? homeModel;

  final ProductsUseCase fetchHomeItemsUseCase;

  Future<void> getProductsData({required BuildContext context}) async {
    emit(GetProductsLoadingState());

    final result = await fetchHomeItemsUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch products: $failure');
        emit(GetProductsErrorState());
      },
      (products) {
        homeModel = products;

        FavouritesCubit.get(context).favorites = {
          for (var p in products) p.id: p.inFavorites ?? false
        };
        CartsCubit.get(context).carts = {
          for (var p in products) p.id: p.inCart ?? false
        };
        print(CartsCubit.get(context).carts);
        emit(GetproductsSuccessState(products));
      },
    );
  }

  /*

  BlocConsumerCategories =>
   loading? progressindicator
   : success? BlocConsumerProducts =>
      loading? progressindicator
      : success? screenDesign
   */
  //
  // void signOut(BuildContext context) {
  //   CacheHelper.removeData(key: 'token').then((value) {
  //     if (value) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //       );
  //     }
  //   });
  // }

  num? _selectedProductId;

  num? get selectedProductId => _selectedProductId;
}
