import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
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
                        print(value);
                        return null;
                      },
                      prefix: Icon(Icons.search),
                      controller: controller,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is SearchLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state is SearchSuccessState
                            ? Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            SearchCubit.get(context)
                                                .searchModel!
                                                .data!
                                                .data![index]
                                                .image!,
                                          ),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                SearchCubit.get(context)
                                                    .searchModel!
                                                    .data!
                                                    .data[index]
                                                    .name!,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              SearchCubit.get(context)
                                                  .searchModel!
                                                  .data!
                                                  .data[index]
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
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data
                                      .length,
                                ),
                              )
                            : state is SearchErrorState
                                ? Text(state.error)
                                : const SizedBox(),
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
