import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/products_entity/product_entity.dart';
import '../../../domain/use_case/home_use_case/products_Use_Case.dart';
import 'get_products_state.dart';

class ProductsCubit extends Cubit<GetProductsState> {
  ProductsCubit({
    required this.fetchHomeItemsUseCase,
  }) : super(ProductsInitialState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  List<ProductEntity>? homeModel;

  final ProductsUseCase fetchHomeItemsUseCase;

  Future<void> getProductsData() async {
    emit(GetProductsLoadingState());

    final result = await fetchHomeItemsUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch products: ${failure.message}');
        emit(GetProductsErrorState());
      },
      (products) {
        homeModel = products;
        emit(GetproductsSuccessState(products: products));
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
