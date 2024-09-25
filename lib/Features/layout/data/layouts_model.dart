import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';

import '../../carts_feature/presentation/screens/cart_screen.dart';
import '../../favourites_feature/presentation/screens/favorites_screen.dart';
import '../../home/presentation/screens/categries_screen.dart';
import '../../home/presentation/screens/products_screen.dart';

class LayoutModel {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const SettingsScreen(),
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
