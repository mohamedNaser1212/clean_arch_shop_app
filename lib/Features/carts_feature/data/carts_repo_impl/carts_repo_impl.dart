import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_local_data_source.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource cartsRemoteDataSource;
  final CartLocalDataSource cartLocalDataSource;
  final RepoManager repoManager;

  const CartsRepoImpl({
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
          return _removeDuplicates(cachedCartItems);
        } else {
          final cart = await cartsRemoteDataSource.getCarts();
          final uniqueCart = _removeDuplicates(cart);
          await cartLocalDataSource.saveCart(cart: uniqueCart);
          return uniqueCart;
        }
      },
    );
  }

  @override
  Future<Either<Failure, bool>> toggleCart({
    required num productIds,
  }) {
    return repoManager.call(
      action: () async {
        final result =
            await cartsRemoteDataSource.toggleCarts(productId: productIds);
        if (result) {
          final updatedCart = await cartsRemoteDataSource.getCarts();
          final uniqueCart = _removeDuplicates(updatedCart);
          await cartLocalDataSource.saveCart(cart: uniqueCart);
        }
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, List<CartEntity>>> removeCarts({
    required num productIds,
  }) {
    return repoManager.call(
      action: () async {
        await cartsRemoteDataSource.removeCarts(productId: productIds);
        await cartLocalDataSource.removeCartItem(productId: productIds);
        final updatedCart = await cartLocalDataSource.getCart();
        final uniqueCart = _removeDuplicates(updatedCart);
        return uniqueCart;
      },
    );
  }

  List<CartEntity> _removeDuplicates(List<CartEntity> cartItems) {
    final uniqueItems = <num, CartEntity>{};
    for (var item in cartItems) {
      uniqueItems[item.id] = item;
    }
    return uniqueItems.values.toList();
  }
}
