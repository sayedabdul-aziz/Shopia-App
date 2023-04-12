import 'package:flutter/material.dart';
import 'package:shopia/core/styles/color_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.width = 130,
    this.radius = 40,
    this.spacer = 8,
  });
  final double width;
  final double radius;
  final double spacer;
  final Function()? onPressed;
  final String text;
  final Color textColor = Colors.white;
  final IconData icon;
  final Color? iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: ColorManager.primaryColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toUpperCase(),
              style: TextStyle(color: textColor),
            ),
            SizedBox(width: spacer),
            Icon(
              icon,
              color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}
