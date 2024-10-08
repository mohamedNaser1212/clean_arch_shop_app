import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../cart_entity/add_to_cart_entity.dart';
import '../carts_repo/cart_repo.dart';

class RemoveCartUseCase {
  final CartRepo cartRepo;

  const RemoveCartUseCase({
    required this.cartRepo,
  });

  Future<Either<Failure, List<CartEntity>>> call({required num products}) {
    return cartRepo.removeCarts(productIds: products);
  }
}
