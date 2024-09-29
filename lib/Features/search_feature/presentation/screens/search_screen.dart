import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_app_bar.dart';


import '../../../../core/service_locator/service_locator.dart';
import '../../domain/search_use_case/fetch_search_use_case.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../widgets/search_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(fetchSearchUseCase: getIt<SearchUseCase>()),
      child: const Scaffold(
        appBar: SearchAppBar(), 
        body: SearchScreenBody(),
      ),
    );
  }
}
