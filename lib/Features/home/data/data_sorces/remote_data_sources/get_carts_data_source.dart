import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/utils/funactions/save_carts.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/changeCartModel.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/api_service.dart';
import '../../../../../core/widgets/constants.dart';
import '../../../../../models/add_to_cart_model.dart';

abstract class GetCartsDataSource {
  Future<Either<Failure, List<AddToCartEntity>>> getCarts();
  Future<Either<Failure, bool>> toggleCarts(num productIds);
}

class GetCartsDataSourceImpl implements GetCartsDataSource {
  List<AddToCartEntity> _cachedCarts = [];
  final ApiService apiService;
  ChangeCartModel? changeCartModel;

  GetCartsDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<AddToCartEntity>>> getCarts() async {
    try {
      final response = await apiService.get(
        endPoint: 'carts',
        headers: {'Authorization': token},
      );

      final addToCartModel = AddToCartModel.fromJson(response);
      final Set<num> uniqueIds = {};
      _cachedCarts = addToCartModel.data?.cartItems
              ?.map((item) {
                if (item.product != null) {
                  return AddToCartEntity(
                    id: item.product!.id ?? 0,
                    name: item.product!.name ?? 'Unknown Product',
                    price: item.product!.price ?? 0.0,
                    oldPrice: item.product!.oldPrice ?? 0.0,
                    description:
                        item.product!.description ?? 'No description available',
                    image: item.product!.image ??
                        'default_image_url', // Provide a default image URL
                  );
                }
                return null;
              })
              .where((item) => item != null)
              .cast<AddToCartEntity>()
              .toList() ??
          [];

      await saveCarts(_cachedCarts, kCartBox);
      return Right(_cachedCarts);
    } catch (e) {
      return Right(await loadCarts(kCartBox));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleCarts(num productIds) async {
    try {
      carts[productIds] = !(carts[productIds] ?? false);
      final response = await apiService.post(
        endPoint: 'carts',
        headers: {'Authorization': token},
        data: {'product_id': productIds},
      );
      changeCartModel = ChangeCartModel.fromJson(response);
      if (changeCartModel!.status = false) {
        carts[productIds] = !(carts[productIds] ?? false);
      } else {
        if (carts[productIds] == true &&
            !_cachedCarts.any((cart) => cart.id == productIds)) {
          await getCarts();
        }
      }
      return Right(carts[productIds] ?? false);
    } catch (e) {
      carts[productIds] = !(carts[productIds] ?? false);
      return Left(ServerFailure(e.toString()));
    }
  }

//   Future<List<AddToCartEntity>> loadFavourites(String boxName) async {
//     var box = await Hive.openBox<AddToCartEntity>(boxName);
//     return box.values.toList();
//   }
// }
}
