import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/search_use_case/fetch_search_use_case.dart';

import '../../../../../models/SearchModel.dart';

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
