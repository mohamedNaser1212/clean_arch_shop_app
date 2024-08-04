import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/search_screen.dart';

import '../Features/home/data/repos/home_repo/home_repo.dart';
import '../Features/home/domain/use_case/categories_use_case/fetch_categories_use_case.dart';
import '../Features/home/domain/use_case/products_use_case/fetch_products_use_case.dart';
import '../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import '../core/utils/funactions/set_up_service_locator.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final fetchProductsUseCase =
            FetchProductsUseCase(getIt.get<HomeRepo>());
        final fetchCategoriesUseCase =
            FetchCategoriesUseCase(getIt.get<HomeRepo>());
        return ShopCubit(fetchProductsUseCase, fetchCategoriesUseCase)
          ..getHomeData();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Shop App'),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context: context, screen: const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    signout(
                      context: context,
                      screen: LoginScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
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
      ),
    );
  }
}
