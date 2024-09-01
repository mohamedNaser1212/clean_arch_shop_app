import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_local_data_source.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource cartsRemoteDataSource;
  final CartLocalDataSource cartLocalDataSource;
  final RepoManager repoManager;

  CartsRepoImpl({
    required this.cartsRemoteDataSource,
    required this.cartLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() {
    return repoManager.call(
      action: () async {
        final cachedCartItems = await cartLocalDataSource.getCart();
        if (cachedCartItems.isNotEmpty) {
          return cachedCartItems;
        } else {
          final cart = await cartsRemoteDataSource.getCarts();
          await cartLocalDataSource.saveCart(cart);
          return cart;
        }
      },
    );
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productIds) {
    return repoManager.call(
      action: () async {
        final result = await cartsRemoteDataSource.toggleCarts(productIds);
        if (result) {
          final updatedCart = await cartsRemoteDataSource.getCarts();
          await cartLocalDataSource.saveCart(updatedCart);
        }
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, List<CartEntity>>> removeCarts(num products) {
    return repoManager.call(
      action: () async {
        await cartsRemoteDataSource.removeCarts(products);
        await cartLocalDataSource.removeCartItem(products);
        final updatedCart = await cartLocalDataSource.getCart();
        return updatedCart;
      },
    );
  }
}
