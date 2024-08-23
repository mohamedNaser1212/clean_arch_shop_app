import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/search_model/search_data.dart';
import '../../../domain/search_use_case/fetch_search_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase fetchSearchUseCase;

  SearchCubit({
    required this.fetchSearchUseCase,
  }) : super(SearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<SearchProduct>? searchResults;

  Future<void> search({
    required String text,
  }) async {
    emit(SearchLoadingState());
    final result = await fetchSearchUseCase.call(text: text);
    result.fold(
      (failure) => emit(SearchErrorState(failure.toString())),
      (data) {
        searchResults = data;
        emit(SearchSuccessState());
      },
    );
  }
}
