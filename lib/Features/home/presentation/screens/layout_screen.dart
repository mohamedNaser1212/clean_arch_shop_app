import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/layout_cubit.dart';
import 'package:shop_app/Features/search_feature/presentation/screens/search_screen.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/utils/widgets/constants.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          // Handle state changes if necessary
        },
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);

          return Scaffold(
            appBar: _buildAppBar(context),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: _buildBottomNavigationBar(cubit),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Shop App', style: TextStyle(color: defaultColor)),
      actions: [
        IconButton(
          onPressed: () {
            navigateTo(context: context, screen: const SearchScreen());
          },
          icon: Icon(
            Icons.search,
            color: defaultColor,
          ),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(LayoutCubit cubit) {
    return BottomNavigationBar(
      items: cubit.bottomNavigationBarItems,
      currentIndex: cubit.currentIndex,
      onTap: (index) {
        cubit.changeScreen(index);
      },
    );
  }
}
