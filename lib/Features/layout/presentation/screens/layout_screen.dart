import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Features/search_feature/presentation/screens/search_screen.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../../../carts_feature/presentation/screens/Cart_screen.dart';
import '../../../favourites_feature/presentation/screens/favorites_screen.dart';
import '../../../home/presentation/screens/categries_screen.dart';
import '../../../home/presentation/screens/products_screen.dart';
import '../../../settings_feature/presentation/screens/settings_screen.dart';
import '../../data/layouts_model.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});

  final List<Widget> _screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart), label: 'Carts'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LayoutModel(),
      child: Consumer<LayoutModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: _screens[model.currentIndex],
            bottomNavigationBar: _buildBottomNavigationBar(context, model),
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

  BottomNavigationBar _buildBottomNavigationBar(
      BuildContext context, LayoutModel model) {
    return BottomNavigationBar(
      items: _bottomNavigationBarItems,
      currentIndex: model.currentIndex,
      onTap: (index) {
        model.changeScreen(index);
      },
    );
  }
}
