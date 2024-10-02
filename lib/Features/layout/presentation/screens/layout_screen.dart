import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/get_carts_cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_products_cubit/get_product_cubit.dart';
import 'package:shop_app/Features/search_feature/presentation/screens/search_screen.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

import '../../../../core/functions/navigations_function.dart';
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

    ProductsCubit.get(context).getProducts();
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
    NavigationFunctions.navigateTo(
      context: context,
      screen: const SearchScreen(),
    );
  }
}
