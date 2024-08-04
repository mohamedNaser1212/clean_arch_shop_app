import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/widgets/constants.dart';
import '../../../../core/widgets/dio_helper.dart';
import '../../../../core/widgets/end_points.dart';
import '../../../../models/GetFavouritsModel.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<Product>>> getFavourites();
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  List<Product> _cachedFavourites = [];

  GetFavouritesDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Product>>> getFavourites() async {
    if (_cachedFavourites.isNotEmpty) {
      return Right(_cachedFavourites);
    }

    try {
      final response = await apiService.get(
        endPoint: favoritesEndPoint,
        headers: {'Authorization': token},
      );

      final favouritesModel = GetFavouritsModel.fromJson(response);
      _cachedFavourites =
          favouritesModel.data!.data!.map((item) => item.product!).toList();

      return Right(_cachedFavourites);
    } catch (e) {
      print('Error fetching favourites: $e');
      return Left(ServerFailure('Error fetching favourites: $e'));
    }
  }
}
