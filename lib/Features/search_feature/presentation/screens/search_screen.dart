import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../domain/search_use_case/fetch_search_use_case.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../widgets/build_search_field.dart';
import '../widgets/build_search_result_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(fetchSearchUseCase: getIt<SearchUseCase>()),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: _buildSearchResults,
        builder: _buildSearchScreen,
      ),
    );
  }

  Widget _buildSearchScreen(BuildContext context, SearchState state) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const CustomTitle(
            title: 'Search',
            style: TitleStyle.style20,
            color: ColorController.whiteColor,
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BuildSearchField(),
            const SizedBox(height: 10),
            _buildSearchResults(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, SearchState state) {
    if (state is SearchLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SearchSuccessState) {
      return const BuildSearchResultList();
    } else if (state is SearchErrorState) {
      return Center(
          child: CustomTitle(
        title: state.error,
        style: TitleStyle.style20,
        color: ColorController.blackColor,
      ));
    } else {
      return const SizedBox.shrink();
    }
  }
}
