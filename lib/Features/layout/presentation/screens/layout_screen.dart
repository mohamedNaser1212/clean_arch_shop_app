import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/search_feature/presentation/screens/search_screen.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/utils/constants.dart';

import '../../data/layouts_model.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  final LayoutModel layoutModel = LayoutModel();

  @override
  void initState() {
    super.initState();
    FavouritesCubit.get(context).getFavorites();
    CartsCubit.get(context).getCarts();
    // ProductsCubit.get(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: layoutModel.currentScreen,
      bottomNavigationBar: _bottomNavigationBody(),
    );
  }

  BottomNavBar _bottomNavigationBody() {
    return BottomNavBar(
      state: this,
      // currentIndex: _layoutModel.currentIndex,
      // items: _layoutModel.bottomNavigationBarItems,
      // onTap: (index) {
      //   setState(() {
      //     _layoutModel.changeScreen(index);
      //   });
      // },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: CustomTitle(
        title: 'Shop App',
        style: TitleStyle.style24,
        color: defaultColor,
      ),
      actions: [
        IconButton(
          onPressed: _onSearchPressed,
          icon: Icon(
            Icons.search,
            color: defaultColor,
          ),
        ),
      ],
    );
  }

  void _onSearchPressed() {
    NavigationManager.navigateTo(
      context: context,
      screen: const SearchScreen(),
    );
  }
}
