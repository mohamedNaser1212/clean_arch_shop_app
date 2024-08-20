import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

import '../../../../core/errors/failure.dart';

class ToggleFavouritesUseCase {
  final FavouritesRepo favouritesRepository;

  ToggleFavouritesUseCase(this.favouritesRepository);

  Future<Either<Failure, bool>> toggleFavouriteCall({
    required num productIds,
  }) async {
    // TODO: implement toggleFavouriteCall
    return await favouritesRepository.toggleFavourite(productId: productIds);
  }
}
