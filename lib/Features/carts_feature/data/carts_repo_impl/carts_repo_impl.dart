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
  Future<Either<Failure, List<CartEntity>>> getCart() async {
    try {
      final cachedCartItems = await cartLocalDataSource.getCart();

      if (cachedCartItems.isNotEmpty) {
        return right(cachedCartItems);
      } else {
        final cart = await cartsDataSource.getCarts();
        await cartLocalDataSource.saveCart(cart);
        return right(cart);
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productIds) async {
    try {
      final result = await cartsDataSource.toggleCarts(productIds);

      if (result) {
        final updatedCart = await cartsDataSource.getCarts();
        await cartLocalDataSource.saveCart(updatedCart);
      }

      return right(result);
    } catch (e) {
      print('Error in toggleCart: $e');
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> removeCarts(num products) async {
    try {
      await cartsDataSource.removeCarts(products);
      await cartLocalDataSource.removeCartItem(products);
      final updatedCart = await cartLocalDataSource.getCart();

      return right(updatedCart);
    } catch (e) {
      print('Error in removeCarts: $e');
      return left(ServerFailure(message: e.toString()));
    }
  }
}
