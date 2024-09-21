import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../widgets/build_search_result_list.dart';
import 'build_search_field.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
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
          ),
        ),
        const SizedBox(height: 10),
        BuildSearchField(),
        const SizedBox(height: 20),
        BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchSuccessState) {
              return const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(12.0),
                child: BuildSearchResultList(),
              ));
            } else if (state is SearchErrorState) {
              return Center(
                child: CustomTitle(
                  title: state.error,
                  style: TitleStyle.style20,
                  color: ColorController.blackColor,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
