import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/utils/funactions/save_carts.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/widgets/constants.dart';
import '../../../../../models/add_to_cart_model.dart';

abstract class AddToCartRemoteDataSource {
  Future<Either<Failure, List<AddToCartEntity>>> getCartItems();
  Future<Either<Failure, bool>> addToCart(List<num> ids);
}

class AddToCartRemoteDataSourceImpl implements AddToCartRemoteDataSource {
  final ApiService apiService;
  List<AddToCartEntity> _cachedCartItems = [];

  AddToCartRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCartItems() async {
    try {
      final response = await apiService.get(
        endPoint: cartEndPoint,
        headers: {'Authorization': token},
      );

      // Convert the response to AddToCartModel
      final cartModel = AddToCartModel.fromJson(response);

      // Extract cart items from the model
      _cachedCartItems = cartModel.data?.cartItems
              ?.map((item) => AddToCartEntity(
                  id: item.id,
                  name: item.name,
                  price: item.price,
                  image: item.image,
                  quantity: item.quantity,
                  description: item.description ?? 'No description available',
                  oldPrice: item.oldPrice))
              .toList() ??
          [];

      await saveCarts(_cachedCartItems, kCartBox);
      return Right(_cachedCartItems);
    } catch (e) {
      print('Error fetching cart items: $e');
      return Left(ServerFailure('Error fetching cart items: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> addToCart(List<num> ids) async {
    try {
      for (var id in ids) {
        final response = await apiService.post(
          endPoint: cartEndPoint,
          headers: {'Authorization': token},
          data: {'product_id': id},
        );

        // Print response for debugging
        print('Response for product ID $id: $response');

        if (response == null || response['data'] == null) {
          print('Error: Response or product data is null.');
          return Left(
              ServerFailure('Error adding to cart: Invalid response data.'));
        }

        final isAdded = response['status'] ?? false;
        if (isAdded) {
          final product = response['data']['product'] ?? {};
          _cachedCartItems.add(
            AddToCartEntity(
              id: product['id'] ?? 0,
              name: product['name'] ?? 'Unknown',
              price: product['price'] ?? '0',
              image: product['image'] ?? '',
              quantity: product['quantity'] ?? '1',
              description: product['description'] ?? 'No description available',
              oldPrice: product['old_price'] ?? '0',
            ),
          );
        } else {
          print('Error: Product not added to cart.');
          return Left(
              ServerFailure('Error adding to cart: Product not added.'));
        }
      }
      await saveCarts(_cachedCartItems, kCartBox);
      return Right(true);
    } catch (e) {
      return Left(ServerFailure('Error adding to cart: $e'));
    }
  }
}
