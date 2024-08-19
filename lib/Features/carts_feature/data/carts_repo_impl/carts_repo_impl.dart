import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource getCartsDataSource;

  CartsRepoImpl({required this.getCartsDataSource});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      final cart = await getCartsDataSource.getCarts();
      //await HiveService.saveData<AddToCartEntity>(cart, kCartBox);
      return right(cart);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productId) async {
    try {
      final result = await getCartsDataSource.toggleCarts(productId);
      await getCart(); // Refresh local cache
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddToCartEntity>>> removeCarts(
      num productId) async {
    try {
      final result = await getCartsDataSource.removeCarts(productId);
      await getCart(); // Refresh local cache
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
