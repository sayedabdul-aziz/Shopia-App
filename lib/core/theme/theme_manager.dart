import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopia/core/styles/color_manager.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: ColorManager.whiteColor,
  appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.whiteColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: ColorManager.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: 19),
      elevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  iconTheme: IconThemeData(color: ColorManager.primaryColor),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(ColorManager.primaryColor))),
  textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          color: ColorManager.greyColor,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      bodySmall: TextStyle(
          color: ColorManager.blackColor,
          fontSize: 12,
          fontWeight: FontWeight.w500)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: ColorManager.whiteColor,
    selectedItemColor: ColorManager.primaryColor,
    unselectedItemColor: ColorManager.greyColor,
    type: BottomNavigationBarType.fixed,
    elevation: 5.0,
  ),
);

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: ColorManager.backgroundColor,
  appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.backgroundColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: ColorManager.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 19),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.backgroundColor,
          statusBarIconBrightness: Brightness.light)),
  iconTheme: IconThemeData(color: ColorManager.primaryColor),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(ColorManager.primaryColor))),
  textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          color: ColorManager.whiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      bodySmall: TextStyle(
          color: ColorManager.whiteColor,
          fontSize: 12,
          fontWeight: FontWeight.w500)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: ColorManager.backgroundColor,
    selectedItemColor: ColorManager.primaryColor,
    unselectedItemColor: ColorManager.greyColor,
    type: BottomNavigationBarType.fixed,
    elevation: 5.0,
  ),
);
