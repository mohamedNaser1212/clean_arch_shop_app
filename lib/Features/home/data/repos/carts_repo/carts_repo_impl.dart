import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/repos/carts_repo/cart_repo.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../data_sorces/remote_data_sources/get_carts_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final GetCartsDataSource getCartsDataSource;

  CartsRepoImpl({required this.getCartsDataSource});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      final cart = await getCartsDataSource.getCarts();
      return cart;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productIds) async {
    try {
      final result = await getCartsDataSource.toggleCarts(productIds);
      return result;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
