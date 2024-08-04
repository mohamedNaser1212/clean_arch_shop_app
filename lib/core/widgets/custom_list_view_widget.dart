import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List items;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final double itemSpacing;

  const CustomListView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.itemSpacing = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      itemBuilder: itemBuilder,
      separatorBuilder: (context, index) => SizedBox(
        width: scrollDirection == Axis.horizontal ? itemSpacing : 0,
        height: scrollDirection == Axis.vertical ? itemSpacing : 0,
      ),
      itemCount: items.length,
    );
  }
}
