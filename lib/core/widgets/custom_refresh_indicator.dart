import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

class CustomRefreshIndicator<T> extends StatelessWidget {
  final Future<void> Function(BuildContext context) onRefresh;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget fallback;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.items,
    required this.itemBuilder,
    this.fallback = const Center(child: LoadingIndicatorWidget()),
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return fallback;
    }

    return RefreshIndicator(
      onRefresh: () => onRefresh(context),
      child: _refreshIndicatorBody(),
    );
  }

  ListView _refreshIndicatorBody() {
    return ListView.separated(
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: items.length,
    );
  }
}
