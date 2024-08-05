import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/dio_helper.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/widgets/constants.dart';
import '../../../../../core/widgets/old_dio_helper.dart';
import '../../../../../models/SearchModel.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  ApiService? apiService;

  //final ApiService apiRequestModel;

//   search(String text) {
//     emit(SearchLoadingState());
//     apiService!.responsePost(endPoint: searchEndPoint, headers: {
//       'Authorization': token,
//     }, data: {
//       'text': text,
//     }).then((value) {
//       searchModel = SearchModel.fromJson(value.data);
//       emit(SearchSuccessState());
//     }).catchError((error) {
//       print('Error searching: $error');
//       emit(SearchErrorState(error.toString()));
//     });
//   }
// }

  search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: searchEndPoint,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print('Error searching: $error');
      emit(SearchErrorState(error.toString()));
    });
  }
}
