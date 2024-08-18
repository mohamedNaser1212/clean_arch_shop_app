import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../cart_entity/add_to_cart_entity.dart';
import '../carts_repo/cart_repo.dart';

class FetchCartUseCase {
  final CartRepo cartRepo;

  FetchCartUseCase(this.cartRepo);

  Future<Either<Failure, List<AddToCartEntity>>> call([num products = 0]) {
    return cartRepo.getCart();
  }
}
