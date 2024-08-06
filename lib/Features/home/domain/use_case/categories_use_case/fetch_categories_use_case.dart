// class FetchCategoriesUseCase  {
//   final HomeRepo homeRepo;
//
//   FetchCategoriesUseCase(this.homeRepo);
//
//   Future<Either<Failure, List<CategoriesModel>>> fetchCategories() async {
//     try {
//       final categories = await homeRepo.fetchCategories();
//       return Right(categories);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/categories_use_case/super_categories_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/home_repo/home_repo.dart';
import '../../entities/categories_entity/categories_entity.dart';

class FetchCategoriesUseCase extends CategoriesUseCase<CategoriesEntity> {
  final HomeRepo homeRepo;
  FetchCategoriesUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<CategoriesEntity>>> call() {
    return homeRepo.fetchCategories();
  }
}
