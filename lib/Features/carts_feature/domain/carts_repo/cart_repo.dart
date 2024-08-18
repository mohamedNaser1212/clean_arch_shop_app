import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../cart_entity/add_to_cart_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, List<AddToCartEntity>>> getCart();
  Future<Either<Failure, bool>> toggleCart(num productIds);
  Future<Either<Failure, List<AddToCartEntity>>> removeCarts(num products);
}
