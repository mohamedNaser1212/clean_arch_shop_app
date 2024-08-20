import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_repo/cart_repo.dart';

import '../../../../core/errors/failure.dart';

class ToggleCartUseCase {
  final CartRepo cartRepo;

  ToggleCartUseCase(this.cartRepo);

  Future<Either<Failure, bool>> toggleCartCall({
    required num products,
  }) {
    return cartRepo.toggleCart(products);
  }
}
