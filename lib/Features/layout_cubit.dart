import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';

import 'carts_feature/presentation/screens/Cart_screen.dart';
import 'favourites_feature/presentation/screens/favorites_screen.dart';
import 'home/presentation/screens/categries_screen.dart';
import 'home/presentation/screens/products_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> get bottomNavigationBarItems {
    return [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.apps), label: 'Categories'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.favorite), label: 'Favorites'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart), label: 'Carts'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: 'Settings'),
    ];
  }

  void changeScreen(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}
