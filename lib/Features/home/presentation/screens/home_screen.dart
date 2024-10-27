import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_home_data_cubit/get_home_data_state.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreenBody(),
    );
  }
}
