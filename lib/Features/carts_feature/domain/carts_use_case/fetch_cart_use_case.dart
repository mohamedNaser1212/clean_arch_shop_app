import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
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