import 'package:dartz/dartz.dart';
import 'package:shop_app/features/home/domain/home_repo/home_repo.dart';

import '../../../../../core/errors_manager/failure.dart';
import '../../entities/categories_entity/categories_entity.dart';

class FetchCategoriesUseCase {
  final HomeRepo homeRepo;

  const FetchCategoriesUseCase({
    required this.homeRepo,
  });

  Future<Either<Failure, List<CategoriesEntity>>> call() {
    return homeRepo.fetchCategories();
  }
}
