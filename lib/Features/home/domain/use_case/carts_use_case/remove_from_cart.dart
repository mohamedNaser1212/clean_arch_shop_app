import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/carts_use_case/super_cart_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../data/repos/carts_repo/cart_repo.dart';
import '../../entities/add_to_cart_entity/add_to_cart_entity.dart';

class RemoveFromCart extends SuperCartUseCase<AddToCartEntity> {
  final CartRepo cartRepo;

  RemoveFromCart(this.cartRepo);

  @override
  Future<Either<Failure, List<AddToCartEntity>>> call([num products = 0]) {
    return cartRepo.removeCarts(products);
  }
}
