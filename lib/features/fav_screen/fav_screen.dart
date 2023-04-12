import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/features/fav_screen/presentation/widgets/fav_item.dart';

import '../../layouts/home_cubit/cubit/home_cubit.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products Favorite'),
          ),
          body: ConditionalBuilder(
            condition: state is! FavoriteDataLoadingState,
            builder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      '     Total : ${HomeCubit.get(context).favoritesListModel!.data!.total}',
                      style: Theme.of(context).textTheme.bodyLarge),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => FavBuildItem(
                              model: HomeCubit.get(context)
                                  .favoritesListModel!
                                  .data!
                                  .data![index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: HomeCubit.get(context)
                              .favoritesListModel!
                              .data!
                              .data!
                              .length),
                    ),
                  ),
                ],
              );
            },
            fallback: (BuildContext context) => const LinearProgressIndicator(
              backgroundColor: Colors.deepOrange,
              color: Colors.white54,
              minHeight: 2,
            ),
          ),
        );
      },
    );
  }
}
