import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../cart_entity/add_to_cart_entity.dart';

abstract class CartRepo {
  const CartRepo();
  Future<Either<Failure, List<CartEntity>>> getCart();
  Future<Either<Failure, bool>> toggleCart({
    required num productIds,
  });
  Future<Either<Failure, List<CartEntity>>> removeCarts({
    required num productIds,
  });
}
