import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../layouts/home_cubit/cubit/home_cubit.dart';
import '../../data/home_model.dart';

class GridBuild extends StatelessWidget {
  final ProductModel? productModel;

  const GridBuild(this.productModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: CarouselSlider(
                    items: productModel?.images.map((e) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
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
                      height: 110,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                if (productModel!.discount != 0)
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: Colors.red,
                      ),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel!.name,
                        maxLines: 2,
                        style: const TextStyle(
                          height: 1.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Price : ${productModel!.price.round()}',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (productModel!.oldPrice != productModel!.price)
                            Text(
                              productModel!.oldPrice.round().toString(),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      HomeCubit.get(context).changeCartIcon(productModel!.id);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          color: HomeCubit.get(context)
                                      .cartList[productModel!.id] ??
                                  false
                              ? Colors.green
                              : const Color.fromARGB(255, 245, 109, 68),
                        ),
                        child:
                            HomeCubit.get(context).cartList[productModel!.id] ??
                                    false
                                ? const Text(
                                    'Added  ✓ ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                : const Text(
                                    'Add to Cart  + ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeFavIcon(productModel!.id);
                    },
                    icon: HomeCubit.get(context).favList[productModel!.id] ??
                            false
                        ? const Icon(Icons.favorite_rounded, color: Colors.red)
                        : const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.red,
                          )),
              ],
            )
          ],
        ));
  }
}
