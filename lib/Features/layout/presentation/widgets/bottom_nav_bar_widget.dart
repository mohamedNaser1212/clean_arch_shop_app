import 'package:flutter/material.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';

class BottomNavBar extends StatefulWidget {
  // final int currentIndex;
  // final List<BottomNavigationBarItem> items;
  // final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    // required this.currentIndex,
    // required this.items,
    // required this.onTap,
    required this.state,
  });
  final LayoutScreenState state;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.state.layoutModel.currentIndex,
      items: widget.state.layoutModel.bottomNavigationBarItems,
      onTap: (index) {
        widget.state.setState(() {
          widget.state.layoutModel.changeScreen(index);
        });
      },
    );
  }
}
