import 'package:flutter/material.dart';

import '../../../../core/styles/color_manager.dart';
import '../../../categories_screen/data/category_model.dart';

class CatBuildItem extends StatelessWidget {
  final DataModel model;
  const CatBuildItem(this.model, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 150,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: ColorManager.greyColor,
        borderRadius: BorderRadius.circular(70),
      ),
      child: Text(model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
