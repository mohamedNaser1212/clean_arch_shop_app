import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_home_data_cubit/get_home_data_state.dart';
import 'package:shop_app/core/widgets/loading_text_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/horizontal_categories_list_view.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/vertical_categories_list_view.dart';

// ignore: must_be_immutable
class CategoriesBody extends StatefulWidget {
  CategoriesBody({
    super.key,
    this.itemHeight,
    this.itemWidth,
    required this.isHorizontal,
  });
//       itemHeight: MediaQuery.of(context).size.height / 5,
//       itemWidth: ,
  double? itemHeight = 250;
  double? itemWidth = double.infinity;
  final bool isHorizontal;

  @override
  State<CategoriesBody> createState() => CategoriesBodyState();
}

class CategoriesBodyState extends State<CategoriesBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetHomeDataCubit, GetHomeDataState>(
      listener: _listener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
    return ConditionalBuilder(
      condition: state is! CategoriesLoading,
      builder: (context) {
        var categoryModel = GetHomeDataCubit.get(context).categoriesModel;

        return widget.isHorizontal == true
            ? HorizontalCategoriesListView(
                state: this,
                categoryModel: categoryModel,
              )
            : VerticalCategoriesListView(
                categoryModel: categoryModel,
                state: this,
              );
      },
      fallback: (context) => const LoadingTextWidget(),
    );
  }

  void _listener(context, state) {}
}
