import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/Features/home/domain/use_case/add_to_cart/super_add_to_cart_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../data/repos/add_to_cart/add_to_cart_repo.dart';

class fetchCarItemsUseCase extends SuperAddToCartUseCase<AddToCartEntity> {
  final AddToCartRepo addToCartRepo;

  fetchCarItemsUseCase(this.addToCartRepo);

  @override
  Future<Either<Failure, List<AddToCartEntity>>> call() async {
    return await addToCartRepo.getCartItems();
  }
}
