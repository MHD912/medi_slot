import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static const String nunitoFont = "Nunito";

  static final ThemeData _theme = ThemeData(
    fontFamily: nunitoFont,
    fontFamilyFallback: const <String>["OpenSans"],
    useMaterial3: true,
  );

  static final ThemeData lightTheme = _theme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightGreyColor,
    colorScheme: lightColorScheme,
    textTheme: TextTheme(),
  );

  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.lightGreyColor,
    brightness: Brightness.light,
  ).copyWith(
    surface: AppColors.lightGreyColor,
    onSurface: AppColors.blackColor,
    primary: AppColors.keppelColor,
    onPrimary: AppColors.lightGreyColor,
    primaryContainer: AppColors.snowColor,
    onPrimaryContainer: AppColors.blackColor,
    secondaryContainer: AppColors.lightGreyColor,
    onSecondaryContainer: AppColors.blackColor,
    outline: AppColors.greyColor,
  );

  static final ThemeData darkTheme = _theme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blackColor,
    colorScheme: darkColorScheme,
    textTheme: TextTheme(),
  );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.blackColor,
    brightness: Brightness.dark,
  ).copyWith(
    surface: AppColors.blackColor,
    onSurface: AppColors.lightGreyColor,
    primary: AppColors.keppelColor,
    onPrimary: AppColors.lightGreyColor,
    primaryContainer: AppColors.blackColor,
    onPrimaryContainer: AppColors.snowColor,
    secondaryContainer: AppColors.blackColor,
    onSecondaryContainer: AppColors.lightGreyColor,
    outline: AppColors.greyColor,
  );
}
