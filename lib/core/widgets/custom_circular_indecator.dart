import 'package:flutter/material.dart';
import 'package:shopia/core/styles/color_manager.dart';

class CustomCircularIndecator extends StatelessWidget {
  const CustomCircularIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorManager.primaryColor,
      ),
    );
  }
}
