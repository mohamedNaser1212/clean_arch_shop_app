import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../search_feature/data/search_model/SearchModel.dart';
import '../../../../search_feature/domain/search_use_case/fetch_search_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FetchSearchUseCase fetchSearchUseCase;

  SearchCubit(this.fetchSearchUseCase) : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<SearchProduct>? searchResults;

  Future<void> search(String text) async {
    emit(SearchLoadingState());
    final result = await fetchSearchUseCase.call(text);
    result.fold(
      (failure) => emit(SearchErrorState(failure.toString())),
      (data) {
        searchResults = data;
        emit(SearchSuccessState());
      },
    );
  }
}
