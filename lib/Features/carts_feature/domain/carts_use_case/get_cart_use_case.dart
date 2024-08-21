import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../cart_entity/add_to_cart_entity.dart';
import '../carts_repo/cart_repo.dart';

class FetchCartUseCase {
  final CartRepo cartRepo;

  const FetchCartUseCase({
    required this.cartRepo,
  });

  Future<Either<Failure, List<AddToCartEntity>>> call() {
    return cartRepo.getCart();
  }
}
