import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/core/styles/color_manager.dart';
import 'package:shopia/features/categories_screen/data/category_model.dart';

import '../../layouts/home_cubit/cubit/home_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Category'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                  itemBuilder: (context, index) => CatItemBuild(
                      HomeCubit.get(context).categoryModel!.data.data[index]),
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.grey),
                  itemCount:
                      HomeCubit.get(context).categoryModel!.data.data.length),
            ),
          );
        },
        listener: (context, state) {});
  }
}

class CatItemBuild extends StatelessWidget {
  final DataModel? model;
  const CatItemBuild(this.model, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(
            image: NetworkImage(model!.image),
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model!.name,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            color: ColorManager.primaryColor,
          )
        ],
      ),
    );
  }
}
