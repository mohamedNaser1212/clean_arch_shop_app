import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/favourite_remote_data_source.dart';
import '../favourite_data_source/favourites_local_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final FavouritesRemoteDataSource favouritesDataSource;
  final FavouritesLocalDataSource favouritesLocalDataSource;
  final RepoManager repoManager;

  const FavouritesRepoImpl({
    required this.favouritesDataSource,
    required this.favouritesLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    return repoManager.call(
      action: () async {
        final cachedFavourites =
            await favouritesLocalDataSource.getFavourites();
        if (cachedFavourites.isNotEmpty) {
          return cachedFavourites;
        } else {
          final favourites = await favouritesDataSource.getFavourites();
          await favouritesLocalDataSource.saveFavourites(favourites);
          return favourites;
        }
      },
    );
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(
      {required num productId}) async {
    return repoManager.call(
      action: () async {
        final result = await favouritesDataSource.toggleFavourites(productId);
        if (result) {
          final updatedFavourites = await favouritesDataSource.getFavourites();
          await favouritesLocalDataSource.saveFavourites(updatedFavourites);
        }
        return result;
      },
    );
  }
}
