import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/data_sorces/remote_data_sources/add_to_cart_data_source.dart';
import 'package:shop_app/Features/home/data/repos/add_to_cart/add_to_cart_repo.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/errors/failure.dart';

class AddToCartRepoImpl extends AddToCartRepo {
  final AddToCartRemoteDataSource cartRemoteDataSource;

  AddToCartRepoImpl(this.cartRemoteDataSource);
  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCartItems() async {
    try {
      final response = await cartRemoteDataSource.getCartItems();
      return response;
    } catch (e) {
      return Left(ServerFailure('Error fetching cart items: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> addToCart(List<num> ids) async {
    try {
      final response = await cartRemoteDataSource.addToCart(ids);
      return response;
    } catch (e) {
      return Left(ServerFailure('Error adding to cart: $e'));
    }
  }
}
