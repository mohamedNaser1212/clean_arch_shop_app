part of 'search_cubit.dart';

class SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {

}

class SearchErrorState extends SearchState {
  final String error;
  SearchErrorState({
    required this.error,
  });
}
