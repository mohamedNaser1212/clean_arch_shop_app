import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';

import '../../../../../core/errors/failure.dart';

abstract class CartRepo {
  Future<Either<Failure, List<AddToCartEntity>>> getCart();
  Future<Either<Failure, bool>> toggleCart(num productIds);
  Future<Either<Failure, List<AddToCartEntity>>> removeCarts(num products);
}
