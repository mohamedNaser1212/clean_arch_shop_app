import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_repo/cart_repo.dart';

import '../../../../core/errors_manager/failure.dart';

class ToggleCartUseCase {
  final CartRepo cartRepo;

  const ToggleCartUseCase({
    required this.cartRepo,
  });

  Future<Either<Failure, bool>> call({
    required num products,
  }) {
    return cartRepo.toggleCart(products);
  }
}
