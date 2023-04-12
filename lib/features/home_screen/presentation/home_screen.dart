import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shopia/core/styles/color_manager.dart';
import 'package:shopia/features/home_screen/presentation/widgets/product_build.dart';

import '../../../core/utils/functions.dart';
import '../../../layouts/home_cubit/cubit/home_cubit.dart';
import '../../cart/presentation/cart_screen.dart';
import '../../search/presentation/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Image.asset(
            'assets/images/splash.png',
            width: 160,
          ),
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(context, SearchScreen());
              },
              icon: Icon(
                Icons.search_rounded,
                size: 25,
                color: ColorManager.primaryColor,
              ),
            ),
            IconButton(
                onPressed: () {
                  navigateTo(context, const CartScreen());
                },
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  size: 25,
                ),
                color: const Color.fromARGB(255, 245, 109, 68))
          ],
        ),
        body: ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel != null &&
                HomeCubit.get(context).categoryModel != null,
            builder: (context) => ProductBuild(HomeCubit.get(context).homeModel,
                HomeCubit.get(context).categoryModel),
            fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 245, 109, 68),
                ))),
      );
    }, listener: (context, state) {
      if (state is ChangeFavSuccessState) {
        if (!state.inFavModel.status) {
          MotionToast.success(description: Text(state.inFavModel.message))
              .show(context);
        }
      }
    });
  }
}
