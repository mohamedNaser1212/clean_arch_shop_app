import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
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
      child: Scaffold(
        appBar: _appBar(context),
        body: const SearchScreenBody(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => _onBackPressed(context), 
      ),
      title: const CustomTitle(
        title: 'Search',
        style: TitleStyle.style20,
        color: ColorController.whiteColor,
      ),
    );
  }


  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }
}
