import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/widgets/constants.dart';
import '../../../../../core/widgets/old_dio_helper.dart';
import '../../../../../models/favoutits_model.dart';
import '../../../../../models/new_favourites_model.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourites(
      num productIds, BuildContext context);
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  List<FavouritesEntity> _cachedFavourites = [];
  ChangeFavouriteModel? changeFavouriteModel;

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
  Future<Either<Failure, bool>> toggleFavourites(
      num productIds, BuildContext context) async {
    try {
      favorites?[productIds] = !(favorites?[productIds] ?? false);
      //emit(ShopChangeFavoriteSuccessState());
      DioHelper.postData(
        url: favoritesEndPoint,
        data: {
          'product_id': productIds,
        },
        token: token,
      ).then((value) {
        changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
        print(favorites.toString());

        print(value.data);
        if (changeFavouriteModel!.status == false) {
          favorites?[productIds] = !(favorites?[productIds] ?? false);
          print(favorites.toString());
        } else {
          getFavourites();
        }
        //   emit(ShopToggleFavoriteSuccessState(changeFavouriteModel!));
      }).catchError((error) {
        favorites?[productIds] = !(favorites?[productIds] ?? false);

        //  emit(ShopToggleFavoriteErrorState(error.toString()));
      });

      return Right(true);
    } catch (e) {
      print('Error toggling favourites: $e');
      return Left(ServerFailure('Error toggling favourites: $e'));
    }
  }
}
