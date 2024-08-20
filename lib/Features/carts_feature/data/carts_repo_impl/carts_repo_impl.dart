import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/models/hive_manager/hive_service.dart';

import '../../../../core/utils/hive_boxes_names/hive_boxes_names.dart';
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
      await hiveService.saveData<AddToCartEntity>(
          cart, HiveBoxesNames.kCartBox);
      return right(cart);
    } catch (e) {
      try {
        // Attempt to load from local cache if remote fetch fails
        final cachedCart = await hiveService
            .loadData<AddToCartEntity>(HiveBoxesNames.kCartBox);
        return right(cachedCart);
      } catch (_) {
        // Return the original failure if both remote fetch and cache load fail
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

      return await getCart();
    } catch (e) {
      print('Error in removeCarts: $e');
      return left(ServerFailure(e.toString()));
    }
  }
}
