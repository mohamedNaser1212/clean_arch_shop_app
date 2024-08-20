import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../cart_entity/add_to_cart_entity.dart';
import '../carts_repo/cart_repo.dart';

class RemoveCartUseCase {
  final CartRepo cartRepo;

  RemoveCartUseCase(this.cartRepo);

  Future<Either<Failure, List<AddToCartEntity>>> removeFromCartCall(
      {required num products}) {
    return cartRepo.removeCarts(products);
  }
}
