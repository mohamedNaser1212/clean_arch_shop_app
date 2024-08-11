import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/repos/carts_repo/cart_repo.dart';
import 'package:shop_app/core/errors/failure.dart';

class ToggleCartUseCase {
  final CartRepo cartRepo;

  ToggleCartUseCase({required this.cartRepo});

  Future<Either<Failure, bool>> call(num productIds) async {
    return await cartRepo.toggleCart(productIds);
  }
}
