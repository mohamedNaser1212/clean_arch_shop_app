import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/search_feature/presentation/screens/search_screen.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../data/layouts_model.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final LayoutModel _layoutModel = LayoutModel();

  @override
  void initState() {
    super.initState();

    FavouritesCubit.get(context).getFavorites();
    CartsCubit.get(context).getCartItems();
    ProductsCubit.get(context).getProductsData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _layoutModel.currentScreen,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _layoutModel.currentIndex,
        items: _layoutModel.bottomNavigationBarItems,
        onTap: (index) {
          setState(() {
            _layoutModel.changeScreen(index);
          });
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
            NavigationManager.navigateTo(
                context: context, screen: const SearchScreen());
          },
          icon: Icon(
            Icons.search,
            color: defaultColor,
          ),
        ),
      ],
    );
  }
}
