import 'package:dartz/dartz.dart';

import 'package:shop_app/core/errors/failure.dart';

import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/get_favourite_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final GetFavouritesDataSource getFavouritesDataSource;

  FavouritesRepoImpl({required this.getFavouritesDataSource});

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final favourites = await getFavouritesDataSource.getFavourites();
      return favourites;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(num productIds) async {
    try {
      final result = await getFavouritesDataSource.toggleFavourites(productIds);
      return result;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
