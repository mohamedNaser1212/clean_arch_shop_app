import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

import '../../../../core/errors_manager/failure.dart';

class ToggleFavouritesUseCase {
  final FavouritesRepo favouritesRepository;

  const ToggleFavouritesUseCase({
    required this.favouritesRepository,
  });

  Future<Either<Failure, bool>> call({
    required num productIds,
  }) async {
    return await favouritesRepository.toggleFavourite(productId: productIds);
  }
}
