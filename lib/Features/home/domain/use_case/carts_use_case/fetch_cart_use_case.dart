import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/Features/home/domain/use_case/carts_use_case/super_cart_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../data/repos/carts_repo/cart_repo.dart';

class FetchCartUseCase extends SuperCartUseCase<AddToCartEntity> {
  final CartRepo cartRepo;

  FetchCartUseCase(this.cartRepo);

  @override
  Future<Either<Failure, List<AddToCartEntity>>> call() async {
    return await cartRepo.getCart();
  }
}
