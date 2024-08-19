import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/models/hive_manager/hive_service.dart';
import 'package:shop_app/core/utils/screens/widgets/end_points.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource cartsDataSource;
  final HiveService hiveService;

  CartsRepoImpl({
    required this.cartsDataSource,
    required this.hiveService,
  });

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      // Fetch from remote source first
      final cart = await cartsDataSource.getCarts();
      // Save to local cache
      await hiveService.saveData<AddToCartEntity>(cart, kCartBox);
      return right(cart);
    } catch (e) {
      try {
        // Attempt to load from local cache if remote fetch fails
        final cachedCart =
            await hiveService.loadData<AddToCartEntity>(kCartBox);
        return right(cachedCart);
      } catch (_) {
        // Return the original failure if both remote fetch and cache load fail
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productId) async {
    try {
      // Toggle cart item on the remote server
      final result = await cartsDataSource.toggleCarts(productId);
      // Refresh the local cache
      final cart = await getCart();
      return right(result);
    } catch (e) {
      print('Error in toggleCart: $e');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddToCartEntity>>> removeCarts(
      num productId) async {
    try {
      // Remove cart item from the remote server
      await cartsDataSource.removeCarts(productId);
      // Refresh the local cache after removal
      return await getCart();
    } catch (e) {
      print('Error in removeCarts: $e');
      return left(ServerFailure(e.toString()));
    }
  }
}
