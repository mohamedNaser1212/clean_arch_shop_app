import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/color_controllers/color_controller.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';

import '../../../../core/utils/screens/products_details_screen.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../search_feature/presentation/cubit/search_cubit/search_cubit.dart';

class BuildSearchResultList extends StatelessWidget {
  const BuildSearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = SearchCubit.get(context).searchResults!;
    return Expanded(
      child: ListView.separated(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return InkWell(
            onTap: () => navigateTo(
              context: context,
              screen: ProductsDetailsScreen(model: result),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.network(
                    result.image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomTitle(
                          title: result.name!,
                          fontSize: 20,
                          color: ColorController.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      CustomTitle(
                        title: result.price.toString(),
                        fontSize: 20,
                        color: ColorController.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
