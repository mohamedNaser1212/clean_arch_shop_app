import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

abstract class CartLocalDataSource {
  Future<Either<Failure, List<AddToCartEntity>>> getCart();
  Future<Either<Failure, void>> saveCart(List<AddToCartEntity> cart);
  Future<Either<Failure, void>> removeCart(num productId);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final HiveHelper hiveService;

  const CartLocalDataSourceImpl({required this.hiveService});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCart() async {
    try {
      final cart =
          await hiveService.loadData<AddToCartEntity>(HiveBoxesNames.kCartBox);
      return right(cart);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCart(List<AddToCartEntity> cart) async {
    try {
      await hiveService.saveData<AddToCartEntity>(
          cart, HiveBoxesNames.kCartBox);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeCart(num productId) async {
    try {
      final cart = await getCart();
      if (cart.isRight()) {
        final updatedCart = cart
            .getOrElse(() => [])
            .where((item) => item.id != productId)
            .toList();
        await saveCart(updatedCart);
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
