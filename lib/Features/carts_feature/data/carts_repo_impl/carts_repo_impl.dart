import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/carts_feature/data/carts_local_data_source/save_carts.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../domain/add_to_cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_repo/cart_repo.dart';
import '../carts_data_source/get_carts_data_source.dart';

class CartsRepoImpl extends CartRepo {
  final GetCartsDataSource getCartsDataSource;

  CartsRepoImpl({required this.getCartsDataSource});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      final cart = await getCartsDataSource.getCarts();
      saveCarts(cart, kCartBox);
      return right(cart);
    } catch (e) {
      return Right(await loadCarts(kCartBox));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCart(num productIds) async {
    try {
      final result = await getCartsDataSource.toggleCarts(productIds);
      await getCart();
      return right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddToCartEntity>>> removeCarts(
      num products) async {
    try {
      final result = await getCartsDataSource.removeCarts(products);
      getCart();
      return right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
