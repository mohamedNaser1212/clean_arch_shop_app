import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../core/models/hive_manager/hive_manager.dart';
import '../../../../core/utils/screens/widgets/end_points.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource getCartsDataSource;

  CartsRepoImpl({required this.getCartsDataSource});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      // Try to load data from cache

      // If cache is empty, fetch from remote data source
      final cart = await getCartsDataSource.getCarts();
      await HiveManager.saveData<AddToCartEntity>(cart, kCartBox);
      carts = {for (var p in cart) p.id!: true};
      return right(cart);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productId) async {
    try {
      // Toggle cart item via remote data source
      final result = await getCartsDataSource.toggleCarts(productId);

      getCart();
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

      getCart();

      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
