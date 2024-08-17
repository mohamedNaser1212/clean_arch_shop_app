import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../core/widgets/constants.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../favourites_local_data_source/save_favourites.dart';
import '../favourites_models/favoutits_model.dart';
import '../favourites_models/new_favourites_model.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourites(num productIds);
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  List<FavouritesEntity> _cachedFavourites = [];
  ChangeFavouriteModel? changeFavouriteModel;

  GetFavouritesDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: favoritesEndPoint,
        headers: {'Authorization': token},
      );
      final response = await apiService.get(
        request: request,
      );

      final favouritesModel = NewFavouritesModel.fromJson(response);

      _cachedFavourites = favouritesModel.data?.data
              ?.map((item) {
                if (item.product != null) {
                  return FavouritesEntity(
                    id: item.product!.id,
                    name: item.product!.name,
                    price: item.product!.price,
                    oldPrice: item.product!.oldPrice,
                    description:
                        item.product!.description ?? 'No description available',
                    discount: item.product!.discount,
                    image: item.product!.image,
                  );
                }
                return null;
              })
              .where((item) => item != null)
              .cast<FavouritesEntity>()
              .toList() ??
          [];

      await saveFavourites(_cachedFavourites, kFavouritesBox);

      return Right(_cachedFavourites);
    } catch (e) {
      print('Error fetching favourites: $e');
      return Right(await loadFavourites(kFavouritesBox));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourites(num productIds) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: favoritesEndPoint,
        headers: {'Authorization': token},
        data: {
          'product_id': productIds,
        },
      );

      final response = await apiService.post(
        request: request,
      );
      changeFavouriteModel = ChangeFavouriteModel.fromJson(response);

      if (changeFavouriteModel!.status == false) {
        return Left(ServerFailure('Failed to toggle favourite'));
      } else {
        return Right(true);
      }
    } catch (e) {
      print('Error toggling favourites: $e');
      return Left(ServerFailure('Error toggling favourites: $e'));
    }
  }
}
