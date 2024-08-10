import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../data_sorces/remote_data_sources/get_favourite_data_source.dart';
import 'favourites_repo.dart';

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
