import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/utils/screens/widgets/cache_helper.dart';
import '../../core/utils/screens/widgets/constants.dart';
import '../../core/utils/screens/widgets/reusable_widgets.dart';
import '../authentication_feature/presentation/screens/login_screen.dart';

class BoardingModel {
  Icon icon;
  String title;
  String body;

  BoardingModel({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  List<BoardingModel> boardingItems = [
    BoardingModel(
      icon: const Icon(Icons.looks_one_rounded),
      title: 'title 1',
      body: 'body 1',
    ),
    BoardingModel(
      icon: const Icon(Icons.looks_two_rounded),
      title: 'title 2',
      body: 'body 2',
    ),
    BoardingModel(
      icon: const Icon(Icons.looks_3_rounded),
      title: 'title 3',
      body: 'body 3',
    ),
  ];
  PageController boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    boardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
                controller: boardingController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    boardingController.previousPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.ease);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Spacer(),
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingItems.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultLightColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    boardingController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.ease);
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            reusableElevatedButton(
              label: 'Skip',
              width: double.infinity,
              backColor: defaultLightColor,
              radius: buttonsBoarderRaduis,
              function: () {
                CacheHelper.saveData(key: 'showBoardingScreen', value: false);
                navigateAndFinish(context: context, screen: LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingItem(BoardingModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(child: item.icon),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            item.title,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          item.body,
        ),
      ],
    );
  }
}
