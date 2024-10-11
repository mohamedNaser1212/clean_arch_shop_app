import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_conditional_builder_widget.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';
import '../../../../core/utils/styles/color_manager.dart';
import '../cubit/search_cubit/search_cubit.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: _listener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
    if (state is SearchLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SearchSuccessState) {
      final results = SearchCubit.get(context).searchResults!;
      return SearchConditionalBuilderWidget(results: results);
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
  }

  void _listener(context, state) {
    if (state is SearchErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
  }
}

