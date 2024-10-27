import 'package:flutter/material.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_widget.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
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
