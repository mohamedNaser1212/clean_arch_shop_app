import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/core/widgets/settings_widgets/build_search_field.dart';

import '../Features/home/domain/use_case/search_use_case/fetch_search_use_case.dart';
import '../core/utils/funactions/set_up_service_locator.dart';
import '../core/widgets/settings_widgets/build_search_result_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt<FetchSearchUseCase>()),
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
          title: CustomTitle(
            title: 'Search',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: whiteColor,
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
        title: 'Error fetching data',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: blackColor,
      ));
    } else {
      return const SizedBox.shrink();
    }
  }
}
