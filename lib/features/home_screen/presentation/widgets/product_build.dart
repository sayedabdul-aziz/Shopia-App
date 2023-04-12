import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../layouts/home_cubit/cubit/home_cubit.dart';
import '../../../categories_screen/data/category_model.dart';
import '../../data/home_model.dart';
import 'category_build.dart';
import 'grid_build.dart';

class ProductBuild extends StatelessWidget {
  final HomeModel? homeModel;
  final CategoryModel? categoryModel;
  late int currentIndex = 0;

  ProductBuild(this.homeModel, this.categoryModel, {super.key});

  CarouselController buttonCarouselController = CarouselController();
  var controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel!.data.banners.map((e) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image(
                    image: NetworkImage(e.image),
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                reverse: false,
                onPageChanged: (index, reason) {
                  currentIndex = index;
                },
                viewportFraction: 0.8,
                initialPage: 0,
                height: 170,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CatBuildItem(categoryModel!.data.data[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: HomeCubit.get(context)
                            .categoryModel!
                            .data
                            .data
                            .length),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            const SizedBox(
              height: 5,
            ),
            Text('  New Products',
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                reverse: false,
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.52,
                children: List.generate(homeModel!.data.products.length,
                    (index) => GridBuild(homeModel!.data.products[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
