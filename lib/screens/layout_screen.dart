import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';
import 'package:shop_app/screens/search_screen.dart';

import '../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import '../core/widgets/constants.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Shop App', style: TextStyle(color: defaultColor)),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context: context, screen: SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                  color: defaultColor,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavigationBarItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeScreen(index);
            },
          ),
        );
      },
    );
  }
}
