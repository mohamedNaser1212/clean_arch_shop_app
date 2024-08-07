import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';
import 'package:shop_app/screens/products_details_screen.dart';

import '../Features/home/domain/use_case/search_use_case/fetch_search_use_case.dart';
import '../core/utils/funactions/set_up_service_locator.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fetchSearchUseCase = getIt.get<FetchSearchUseCase>();

    return BlocProvider(
      create: (context) => SearchCubit(fetchSearchUseCase),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // Implement listener if needed
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Search')),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    reusableTextFormField(
                      label: 'Search',
                      onTap: () {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Search must not be empty';
                        }
                        return null;
                      },
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).search(value!);
                        }
                        return null;
                      },
                      prefix: Icon(Icons.search),
                      controller: controller,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    if (state is SearchLoadingState)
                      const Center(child: CircularProgressIndicator())
                    else if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              navigateTo(
                                context: context,
                                screen: ProductsDetailsScreen(
                                  model: SearchCubit.get(context)
                                      .searchResults![index],
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      SearchCubit.get(context)
                                          .searchResults![index]
                                          .image!,
                                    ),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          SearchCubit.get(context)
                                              .searchResults![index]
                                              .name!,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        SearchCubit.get(context)
                                            .searchResults![index]
                                            .price
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount:
                              SearchCubit.get(context).searchResults!.length,
                        ),
                      )
                    else if (state is SearchErrorState)
                      Text(state.error)
                    else
                      const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
