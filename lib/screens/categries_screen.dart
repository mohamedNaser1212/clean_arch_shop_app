import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            var categoryModel = ShopCubit.get(context).categoriesModel;
            return screenBuilder(categoryModel!, context);
          },
          fallback: (context) => const Center(child: Text('Loading...')),
        );
      },
    );
  }

  Widget screenBuilder(List<DataModel> categoryModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        categoryItem(categoryModel[index], context),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                    itemCount: categoryModel.length)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(DataModel item, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                width: MediaQuery.of(context).size.height / 6,
                height: MediaQuery.of(context).size.height / 6,
                fit: BoxFit.cover,
                image: NetworkImage(
                  '${item.image}',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${item.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
      ),
    );
  }
}
