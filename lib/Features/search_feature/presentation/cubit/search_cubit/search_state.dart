part of 'search_cubit.dart';

class SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  // final List<SearchModel> searchModel;
  // SearchSuccessState(this.searchModel);
}

class SearchErrorState extends SearchState {
  final String error;
  SearchErrorState(this.error);
}
