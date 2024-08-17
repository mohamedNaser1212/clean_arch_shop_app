import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_use_case/super_fetch_favourites_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../favourites_entity/favourites_entity.dart';
import '../favourites_repo/favourites_repo.dart';

class FetchFavouritesUseCase extends FavouritesUseCase<FavouritesEntity> {
  final FavouritesRepo favouritesRepo;

  FetchFavouritesUseCase(this.favouritesRepo);

  @override
  Future<Either<Failure, List<FavouritesEntity>>> call() async {
    return await favouritesRepo.getFavourites();
  }
}
