import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layouts/home_cubit/cubit/home_cubit.dart';
import '../../data/search_model.dart';

class SearchBuildItem extends StatelessWidget {
  ProductData model;

  SearchBuildItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).focusColor,
          ),
          width: double.infinity,
          height: 170,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 120,
              height: 150,
              child: CarouselSlider(
                items: model.images!.map((e) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image(
                      image: NetworkImage(e),
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  reverse: false,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  height: 120,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Price : ${model.price!.round()}',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            HomeCubit.get(context)
                                .changeCartIcon(model.id ?? 0);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                color: HomeCubit.get(context)
                                            .cartList[model.id] ??
                                        false
                                    ? Colors.green
                                    : const Color.fromARGB(255, 245, 109, 68),
                              ),
                              child:
                                  HomeCubit.get(context).cartList[model.id] ??
                                          false
                                      ? const Text(
                                          'Added  ✓ ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )
                                      : const Text(
                                          'Add to Cart  + ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            HomeCubit.get(context).changeFavIcon(model.id ?? 0);
                          },
                          icon:
                              HomeCubit.get(context).favList[model.id] ?? false
                                  ? const Icon(Icons.favorite_rounded,
                                      color: Colors.red)
                                  : const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.red,
                                    )),
                    ],
                  )
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
