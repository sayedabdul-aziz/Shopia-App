import 'package:flutter/material.dart';

import '../../../../layouts/home_cubit/cubit/home_cubit.dart';
import '../../data/fav_list_model.dart';

class FavBuildItem extends StatelessWidget {
  DataModel? model;

  FavBuildItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: 170,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image(
                image: NetworkImage(model!.product!.image ?? ''),
                width: 140,
                height: 140,
              ),
            ),
            if (model!.product!.discount != 0)
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
                  ))
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.product!.name ?? '',
                maxLines: 2,
                style: const TextStyle(
                  height: 1.3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Price : ${model!.product!.price!.round()}',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model!.product!.oldPrice != model!.product!.price!)
                    Text(
                      model!.product!.oldPrice!.round().toString(),
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        HomeCubit.get(context)
                            .changeCartIcon((model!.product!.id) ?? 0);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            color: HomeCubit.get(context)
                                        .cartList[(model!.product!.id) ?? 0] ??
                                    false
                                ? Colors.green
                                : const Color.fromARGB(255, 245, 109, 68),
                          ),
                          child: HomeCubit.get(context)
                                      .cartList[(model!.product!.id) ?? 0] ??
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
                        HomeCubit.get(context)
                            .changeFavIcon((model!.product!.id) ?? 0);
                      },
                      icon: HomeCubit.get(context)
                                  .favList[(model!.product!.id) ?? 0] ??
                              false
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
  }
}
