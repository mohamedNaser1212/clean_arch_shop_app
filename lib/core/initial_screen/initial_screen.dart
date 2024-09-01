import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../user_info/cubit/user_info_cubit.dart';
import '../user_info/domain/use_cases/get_user_info_use_case.dart';
import '../utils/widgets/connection_failure_widget.dart';
import 'manager/internet_manager/internet_manager.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    super.key,
  });

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isConnected = true;
  bool isInitializing = true;
  InternetManager internetManager = getIt.get<InternetManager>();
  @override
  void initState() {
    super.initState();
    _checkConnection();
    ProductsCubit.get(context).getProductsData(context: context);
  }

  Future<void> _checkConnection() async {
    final hasConnection = await internetManager.checkConnection();

    setState(() {
      isConnected = hasConnection;
      isInitializing = false;
    });
  }

  void _retryInitialization() async {
    setState(() {
      isInitializing = true;
    });
    await _checkConnection();
    if (isConnected) {
      await _checkConnection();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isInitializing) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!isConnected) {
      return ConnectionFailureWidget(
        onPressed: _retryInitialization,
      );
    }

    return BlocProvider<UserInfoCubit>(
      create: (context) => UserInfoCubit(
        getUserUseCase: getIt<GetUserInfoUseCase>(),
      )..getUserData(),
      child: BlocListener<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
          if (isConnected && state is GetUserInfoSuccessState) {
            NavigationManager.navigateAndFinish(
              context: context,
              screen: const LayoutScreen(),
            );
          }
        },
        child: Scaffold(
          body: BlocBuilder<UserInfoCubit, UserInfoState>(
            builder: (context, state) {
              if (state is GetUserInfoLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetUserInfoErrorState) {
                return LoginScreen();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
