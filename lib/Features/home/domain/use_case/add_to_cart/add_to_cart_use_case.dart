import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/add_to_cart/add_to_cart_repo.dart';

class AddToCartUseCase {
  final AddToCartRepo addToCartRepo;

  AddToCartUseCase(this.addToCartRepo);
  Future<Either<Failure, bool>> call(List<num> productIds) async {
    return await addToCartRepo.addToCart(productIds);
  }
}
