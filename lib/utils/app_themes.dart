import 'package:flutter/material.dart';
import 'package:lockify/utils/app_colors.dart';


abstract class AppThemes{
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLightColor,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDarkColor,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}