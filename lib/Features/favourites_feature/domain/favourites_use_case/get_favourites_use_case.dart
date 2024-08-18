import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../favourites_entity/favourites_entity.dart';
import '../favourites_repo/favourites_repo.dart';

class GetFavouritesUseCases {
  final FavouritesRepo favouritesRepo;

  GetFavouritesUseCases(this.favouritesRepo);

  Future<Either<Failure, List<FavouritesEntity>>> call() async {
    return await favouritesRepo.getFavourites();
  }
}
