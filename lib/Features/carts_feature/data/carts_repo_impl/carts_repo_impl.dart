import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_local_data_source.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource cartsDataSource;
  final CartLocalDataSource cartLocalDataSource;

  const CartsRepoImpl({
    required this.cartsDataSource,
    required this.cartLocalDataSource,
  });

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      final cart = await cartsDataSource.getCarts();

      await cartLocalDataSource.saveCart(cart);
      return right(cart);
    } catch (e) {
      try {
        final cachedCart = await cartLocalDataSource.getCart();
        return right(cachedCart.getOrElse(() => []));
      } catch (_) {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productIds) async {
    try {
      final result = await cartsDataSource.toggleCarts(productIds);

      final cart = await getCart();
      return right(cart.isRight() ? result : false);
    } catch (e) {
      print('Error in toggleCart: $e');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddToCartEntity>>> removeCarts(
      num productId) async {
    try {
      await cartsDataSource.removeCarts(productId);

      final removeResult = await cartLocalDataSource.removeCart(productId);
      return removeResult.isRight()
          ? await getCart()
          : left(removeResult
              .swap()
              .getOrElse(() => ServerFailure('Failed to remove cart item')));
    } catch (e) {
      print('Error in removeCarts: $e');
      return left(ServerFailure(e.toString()));
    }
  }
}
