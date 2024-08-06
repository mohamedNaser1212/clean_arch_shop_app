import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/utils/funactions/save_favourites.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/GetFavouritsModel.dart';

import '../../../../../core/widgets/constants.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourite(num productId);
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  List<FavouritesEntity> _cachedFavourites = [];

  GetFavouritesDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final response = await apiService.get(
        endPoint: favoritesEndPoint,
        headers: {'Authorization': token},
      );

      final favouritesModel = GetFavouritsModel.fromJson(response);
      _cachedFavourites = favouritesModel.data?.data
              ?.map((item) => FavouritesEntity(
                    id: item.product!.id,
                    name: item.product!.name,
                    price: item.product!.price,
                    oldPrice: item.product!.oldPrice,
                    discount: item.product!.discount,
                    image: item.product!.image,
                  ))
              .toList() ??
          [];

      await saveFavourites(_cachedFavourites, kFavouritesBox);

      return Right(_cachedFavourites);
    } catch (e) {
      print('Error fetching favourites: $e');
      return Left(ServerFailure('Error fetching favourites: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(num productId) async {
    try {
      final response = await apiService.post(
        endPoint: favoritesEndPoint,
        headers: {'Authorization': token},
        data: {'product_id': productId},
      );

      final isFavourite = response['status'];

      // Update the cached favorites list
      if (isFavourite) {
        _cachedFavourites.removeWhere((product) => product.id == productId);
      } else {
        final productResponse = await apiService.get(
          endPoint: 'products/$productId',
          headers: {'Authorization': token},
        );
        final product = ProductEntity.fromJson(productResponse);
        _cachedFavourites.add(
          FavouritesEntity(
            id: product.id,
            name: product.name,
            price: product.price,
            oldPrice: product.oldPrice,
            discount: product.discount,
            image: product.image,
          ),
        );
      }

      await saveFavourites(_cachedFavourites, kFavouritesBox);

      return Right(isFavourite);
    } catch (e) {
      print('Error toggling favourite: $e');
      return Left(ServerFailure('Error toggling favourite: $e'));
    }
  }
}
