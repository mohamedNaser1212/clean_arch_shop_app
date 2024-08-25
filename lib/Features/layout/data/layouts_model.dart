import 'package:flutter/material.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';

import '../../carts_feature/presentation/screens/Cart_screen.dart';
import '../../favourites_feature/presentation/screens/favorites_screen.dart';
import '../../home/presentation/screens/categries_screen.dart';
import '../../home/presentation/screens/products_screen.dart';

class LayoutModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<Widget> _screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];

  // Getter for the screens list
  List<Widget> get screens => _screens;

  // Bottom navigation items
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart), label: 'Carts'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  // Getter for the bottom navigation items
  List<BottomNavigationBarItem> get bottomNavigationBarItems =>
      _bottomNavigationBarItems;

  // Method to change the current screen index
  void changeScreen(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
