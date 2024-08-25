import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/utils/screens/products_details_screen.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../data/search_model/search_response_model.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key, required this.results});
  final List<SearchResponseModel> results;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          print(result);
          return ConditionalBuilder(
            condition: results.isNotEmpty,
            builder: (context) => InkWell(
              onTap: () => navigateTo(
                context: context,
                screen: ProductsDetailsScreen(model: result),
              ),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: ColorController.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: ColorController.dividerColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      result.image,
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
                            title: result.name,
                            style: TitleStyle.style20,
                            maxLines: 2,
                            color: ColorController.blackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTitle(
                          title: 'Price: ${result.price}',
                          style: TitleStyle.style20,
                          color: ColorController.redAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(
              child: CustomTitle(
                title: 'No results found',
                style: TitleStyle.style20,
                color: ColorController.blackColor,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
