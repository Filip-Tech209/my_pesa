// theme.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color.fromARGB(255, 28, 160, 37);
  static const Color secondaryBlue = Color.fromARGB(255, 29, 149, 37);
  static const Color lightBg = Color.fromARGB(255, 244, 246, 243);
  static const Color darkBg = Color.fromARGB(255, 45, 45, 45);
}

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightBg,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryBlue),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryBlue,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 28, 160, 37),
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkBg),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 28, 160, 37),
      secondary: Color.fromARGB(255, 63, 149, 29),
      surface: Color.fromARGB(255, 49, 49, 49),
    ),
  );
}