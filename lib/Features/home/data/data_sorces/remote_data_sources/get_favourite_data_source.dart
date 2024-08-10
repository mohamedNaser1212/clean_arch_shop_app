import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/widgets/constants.dart';
import '../../../../../models/new_favourites_model.dart';
import '../../../../../models/new_get_home_data.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourites(List<num> productIds);
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

      final favouritesModel = NewFavouritesModel.fromJson(response);
      _cachedFavourites = favouritesModel.data?.data
              ?.map((item) => FavouritesEntity(
                    id: item.product!.id,
                    name: item.product!.name,
                    price: item.product!.price,
                    oldPrice: item.product!.oldPrice,
                    description:
                        item.product!.description ?? 'No description available',
                    discount: item.product!.discount,
                    image: item.product!.image,
                  ))
              .toList() ??
          [];

      // await saveFavourites(_cachedFavourites, kFavouritesBox);

      return Right(_cachedFavourites);
    } catch (e) {
      print('Error fetching favourites: $e');
      return Left(ServerFailure('Error fetching favourites: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourites(List<num> productIds) async {
    try {
      for (var productId in productIds) {
        final response = await apiService.post(
          endPoint: favoritesEndPoint,
          headers: {'Authorization': token},
          data: {'product_id': productId},
        );

        final isFavourite = response['status'];

        if (isFavourite) {
          _cachedFavourites.removeWhere((product) => product.id == productId);
        } else {
          final productResponse = await apiService.get(
            endPoint: 'products/$productId',
            headers: {'Authorization': token},
          );
          final product = Products.fromJson(productResponse);
          _cachedFavourites.add(
            FavouritesEntity(
              id: product.id,
              name: product.name,
              price: product.price,
              oldPrice: product.oldPrice,
              discount: product.discount,
              description: product.description ?? 'No description available',
              image: product.image,
            ),
          );
        }
      }

      // await saveFavourites(_cachedFavourites, kFavouritesBox);

      return Right(true);
    } catch (e) {
      print('Error toggling favourites: $e');
      return Left(ServerFailure('Error toggling favourites: $e'));
    }
  }
}
