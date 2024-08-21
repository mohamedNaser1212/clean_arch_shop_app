import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/favourite_remote_data_source.dart';
import '../favourite_data_source/favourites_local_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final FavouritesRemoteDataSource favouritesDataSource;
  final FavouritesLocalDataSource favouritesLocalDataSource;

  FavouritesRepoImpl({
    required this.favouritesDataSource,
    required this.favouritesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final favourites = await favouritesDataSource.getFavourites();
      await favouritesLocalDataSource.saveFavourites(favourites);
      return right(favourites);
    } catch (e) {
      try {
        final cachedFavourites =
            await favouritesLocalDataSource.getFavourites();
        return right(cachedFavourites.getOrElse(() => []));
      } catch (_) {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(
      {required num productId}) async {
    try {
      final result = await favouritesDataSource.toggleFavourites(productId);
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
