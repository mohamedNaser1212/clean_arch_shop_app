import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_screen_body.dart';
import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favourites_screen_body.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/home_body.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_screen_body.dart';

class LayoutModel {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreenBody(),
    CategoriesScreenBody(),
    const FavoritesScreenBody(),
    const CartScreenBody(),
    const SettingsScreenBody(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart), label: 'Carts'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  int get currentIndex => _currentIndex;

  Widget get currentScreen => _screens[_currentIndex];

  List<BottomNavigationBarItem> get bottomNavigationBarItems =>
      _bottomNavigationBarItems;

  void changeScreen(int index) {
    _currentIndex = index;
  }
}
