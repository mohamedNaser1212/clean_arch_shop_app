import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/favourites_use_case/super_fetch_favourites_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/favourites_repo/favourites_repo.dart';
import '../../entities/favourites_entity/favourites_entity.dart';

class FetchFavouritesUseCase extends FavouritesUseCase<FavouritesEntity> {
  final FavouritesRepo favouritesRepo;

  FetchFavouritesUseCase(this.favouritesRepo);

  @override
  Future<Either<Failure, List<FavouritesEntity>>> call() async {
    return await favouritesRepo.getFavourites();
  }
}
