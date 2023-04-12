import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopia/features/cart/presentation/widgets/fav_item.dart';

import '../../../layouts/home_cubit/cubit/home_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! CartDataLoadingState,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('My Cart'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => CartBuildItem(
                              model: HomeCubit.get(context)
                                  .cartListModel!
                                  .data!
                                  .cartItems![index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: HomeCubit.get(context)
                              .cartListModel!
                              .data!
                              .cartItems!
                              .length),
                    ),
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) => const LinearProgressIndicator(
            backgroundColor: Colors.deepOrange,
            color: Colors.white54,
            minHeight: 2,
          ),
        );
      },
    );
  }
}
