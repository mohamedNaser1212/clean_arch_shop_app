import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/errors_manager/internet_failure.dart';
import '../../../../core/initial_screen/manager/internet_manager/internet_manager.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/favourite_remote_data_source.dart';
import '../favourite_data_source/favourites_local_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final FavouritesRemoteDataSource favouritesDataSource;
  final FavouritesLocalDataSource favouritesLocalDataSource;
  final InternetManager internetManager;

  const FavouritesRepoImpl({
    required this.favouritesDataSource,
    required this.favouritesLocalDataSource,
    required this.internetManager,
  });

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final cachedFavouriteData =
          await favouritesLocalDataSource.getFavourites();

      if (cachedFavouriteData.isNotEmpty) {
        final nonNullableCachedFavourites =
            cachedFavouriteData.whereType<FavouritesEntity>().toList();
        return right(nonNullableCachedFavourites);
      } else {
        final favourites = await favouritesDataSource.getFavourites();
        await favouritesLocalDataSource.saveFavourites(favourites);
        return right(favourites);
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(
      {required num productId}) async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return Left(
          InternetFailure.fromConnectionStatus(
              InternetConnectionStatus.disconnected),
        );
      }
      final result = await favouritesDataSource.toggleFavourites(productId);

      if (result) {
        final updatedFavourites = await favouritesDataSource.getFavourites();
        await favouritesLocalDataSource.saveFavourites(updatedFavourites);
      }

      return right(result);
    } catch (e) {
      print('Error in toggleFavourite: $e');
      return left(ServerFailure(message: e.toString()));
    }
  }
}
