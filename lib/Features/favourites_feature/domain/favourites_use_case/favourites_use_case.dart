import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/super_favourites_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../favourites_entity/favourites_entity.dart';
import '../favourites_repo/favourites_repo.dart';

class FavouritesUseCases extends SuperFavouritesUseCase<FavouritesEntity> {
  final FavouritesRepo favouritesRepo;

  FavouritesUseCases(this.favouritesRepo);

  @override
  Future<Either<Failure, List<FavouritesEntity>>> call() async {
    return await favouritesRepo.getFavourites();
  }

  @override
  Future<Either<Failure, bool>> toggleFavouriteCall(num productIds) async {
    // TODO: implement toggleFavouriteCall
    return await favouritesRepo.toggleFavourite(productIds);
  }
}
