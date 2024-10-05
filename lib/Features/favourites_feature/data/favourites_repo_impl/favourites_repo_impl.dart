import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/favourite_remote_data_source.dart';
import '../favourite_data_source/favourites_local_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final FavouritesRemoteDataSource favouritesRemoteDataSource;
  final FavouritesLocalDataSource favouritesLocalDataSource;
  final RepoManager repoManager;

  const FavouritesRepoImpl({
    required this.favouritesRemoteDataSource,
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
          return _removeDuplicates(favourites: cachedFavourites);
        } else {
          final favourites = await favouritesRemoteDataSource.getFavourites();
          final uniqueFavourites = _removeDuplicates(favourites: favourites);
          await favouritesLocalDataSource.saveFavourites(
              favourites: uniqueFavourites);
          return uniqueFavourites;
        }
      },
    );
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(
      {required num productId}) async {
    return repoManager.call(
      action: () async {
        final result = await favouritesRemoteDataSource.toggleFavourites(
            productId: productId);
        if (result) {
          final updatedFavourites =
              await favouritesRemoteDataSource.getFavourites();
          final uniqueFavourites =
              _removeDuplicates(favourites: updatedFavourites);
          await favouritesLocalDataSource.saveFavourites(
              favourites: uniqueFavourites);
        }
        return result;
      },
    );
  }

  List<FavouritesEntity> _removeDuplicates(
      {required List<FavouritesEntity> favourites}) {
    final uniqueItems = <num, FavouritesEntity>{};
    for (var item in favourites) {
      uniqueItems[item.id] = item;
    }
    return uniqueItems.values.toList();
  }
}
