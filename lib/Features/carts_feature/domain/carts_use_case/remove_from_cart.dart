import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/super_cart_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../add_to_cart_entity/add_to_cart_entity.dart';
import '../carts_repo/cart_repo.dart';

class RemoveFromCart extends SuperCartUseCase<AddToCartEntity> {
  final CartRepo cartRepo;

  RemoveFromCart(this.cartRepo);

  @override
  Future<Either<Failure, List<AddToCartEntity>>> call([num products = 0]) {
    return cartRepo.removeCarts(products);
  }
}
