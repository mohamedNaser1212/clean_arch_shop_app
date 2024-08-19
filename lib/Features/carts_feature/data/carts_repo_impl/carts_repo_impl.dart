import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/models/hive_manager/hive_service.dart';
import 'package:shop_app/core/utils/screens/widgets/end_points.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_sources/carts_remote_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final CartsRemoteDataSource getCartsDataSource;
  final HiveService hiveService;

  CartsRepoImpl({
    required this.getCartsDataSource,
    required this.hiveService,
  });

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      // Fetch from remote source first
      final cart = await getCartsDataSource.getCarts();
      // Save to local cache
      await hiveService.saveData<AddToCartEntity>(cart, kCartBox);
      return right(cart);
    } catch (e) {
      // Attempt to load from local cache if remote fetch fails
      try {
        final cachedCart =
            await hiveService.loadData<AddToCartEntity>(kCartBox);
        return right(cachedCart);
      } catch (_) {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productId) async {
    try {
      final result = await getCartsDataSource.toggleCarts(productId);

      await getCart();
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
      final result = await getCartsDataSource.removeCarts(productId);
      // Refresh local cache after removing
      return await getCart();
    } catch (e) {
      print('Error in removeCarts: $e');
      return left(ServerFailure(e.toString()));
    }
  }
}
