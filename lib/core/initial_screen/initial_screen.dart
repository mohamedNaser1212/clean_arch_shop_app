import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../user_info/cubit/user_info_cubit.dart';
import '../user_info/domain/use_cases/get_user_info_use_case.dart';
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
    _initialize();
    ProductsCubit.get(context).getProductsData(context: context);
  }

  Future<void> _initialize() async {
    await _checkConnection();
  }

  Future<void> _checkConnection() async {
    final hasConnection = await internetManager.checkConnection();
    if (mounted) {
      setState(() {
        isConnected = hasConnection;
        isInitializing = false;
      });
    }
  }

  void _retryInitialization() async {
    setState(() {
      isInitializing = true;
    });
    await _checkConnection();
    if (isConnected) {
      _initialize();
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
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please check your connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _retryInitialization,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
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
