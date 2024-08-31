import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/errors_manager/internet_failure.dart';
import '../../../../core/initial_screen/manager/internet_manager/internet_manager.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_local_data_source.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource cartsRemoteDataSource;
  final CartLocalDataSource cartLocalDataSource;
  final InternetManager internetManager;

  const CartsRepoImpl({
    required this.cartsRemoteDataSource,
    required this.cartLocalDataSource,
    required this.internetManager,
  });

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        InternetFailure.fromConnectionStatus(
            InternetConnectionStatus.disconnected);
      }
      final cachedCartItems = await cartLocalDataSource.getCart();

      if (cachedCartItems.isNotEmpty) {
        return right(cachedCartItems);
      } else {
        final cart = await cartsRemoteDataSource.getCarts();
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
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return Left(
          InternetFailure.fromConnectionStatus(
              InternetConnectionStatus.disconnected),
        );
      }
      final result = await cartsRemoteDataSource.toggleCarts(productIds);

      if (result) {
        final updatedCart = await cartsRemoteDataSource.getCarts();
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
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        InternetFailure.fromConnectionStatus(
            InternetConnectionStatus.disconnected);
      }
      await cartsRemoteDataSource.removeCarts(products);
      await cartLocalDataSource.removeCartItem(products);
      final updatedCart = await cartLocalDataSource.getCart();

      return right(updatedCart);
    } catch (e) {
      print('Error in removeCarts: $e');
      return left(ServerFailure(message: e.toString()));
    }
  }
}
