import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/functions/navigations_function.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/utils/constants.dart';
import '../utils/stripe_key/stripe_keys.dart';
import '../utils/bloc_observer/bloc_observer.dart';
import 'initial_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Bloc.observer = const MyBlocObserver();
    Stripe.publishableKey = ApiKeys.publishableKey;
    setUpServiceLocator();
    _navigateAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        splashImage,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  void _navigateAfterDelay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        await Future.delayed(const Duration(seconds: 3));

        if (mounted) {
          NavigationFunctions.navigateAndFinish(
            context: context,
            screen: const InitialScreen(),
          );
        }
      });
    });
  }
}
