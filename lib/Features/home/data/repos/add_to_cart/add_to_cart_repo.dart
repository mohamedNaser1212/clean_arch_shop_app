import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/errors/failure.dart';

abstract class AddToCartRepo {
  Future<Either<Failure, List<AddToCartEntity>>> getCartItems();
  Future<Either<Failure, bool>> addToCart(List<num> ids);
}
