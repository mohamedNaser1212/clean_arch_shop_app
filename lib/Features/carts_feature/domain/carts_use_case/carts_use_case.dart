import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/super_cart_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../cart_entity/add_to_cart_entity.dart';
import '../carts_repo/cart_repo.dart';

class FetchCartUseCase extends SuperCartUseCase<AddToCartEntity> {
  final CartRepo cartRepo;

  FetchCartUseCase(this.cartRepo);

  @override
  Future<Either<Failure, List<AddToCartEntity>>> call([num products = 0]) {
    return cartRepo.getCart();
  }

  @override
  Future<Either<Failure, List<AddToCartEntity>>> removeFromCartCall(
      [num products = 0]) {
    return cartRepo.removeCarts(products);
  }

  @override
  Future<Either<Failure, bool>> toggleCartCall(num products) {
    return cartRepo.toggleCart(products);
  }
}
