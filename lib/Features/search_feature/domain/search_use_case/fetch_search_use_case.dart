import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../data/search_model/SearchModel.dart';
import '../search_repo/search_repo.dart';

class SearchUseCase {
  final SearchRepo searchRepo;

  const SearchUseCase({
    required this.searchRepo,
  });

  Future<Either<Failure, List<SearchProduct>>> call({
    required String text,
  }) {
    return searchRepo.search(text: text);
  }
}
