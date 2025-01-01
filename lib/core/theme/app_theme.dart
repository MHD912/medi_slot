import 'package:flutter/material.dart';

import '../../shared/localization/cubit/localization_cubit.dart';
import '../utilities/global_variables.dart';
import 'app_colors.dart';

class AppTheme {
  static const String nunitoFont = "Nunito";
  static const String notoSansArabicFont = "NotoSansArabic";

  static ThemeData _theme(Locale locale) {
    final locale = getIt.get<LocalizationCubit>().activeLocale;
    return ThemeData(
      fontFamily:
          (locale.languageCode == 'en') ? nunitoFont : notoSansArabicFont,
      useMaterial3: true,
    );
  }

  static ThemeData lightTheme(Locale locale) => _theme(locale).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightGreyColor,
        colorScheme: lightColorScheme,
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

  static ThemeData darkTheme(Locale locale) => _theme(locale).copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.blackColor,
        colorScheme: darkColorScheme,
      );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.blackColor,
    brightness: Brightness.dark,
  ).copyWith(
    surface: AppColors.blackColor,
    onSurface: AppColors.lightGreyColor,
    primary: AppColors.keppelColor,
    onPrimary: AppColors.lightGreyColor,
    primaryContainer: AppColors.darkGreyColor,
    onPrimaryContainer: AppColors.snowColor,
    secondaryContainer: AppColors.darkGreyColor,
    onSecondaryContainer: AppColors.snowColor,
    outline: AppColors.greyColor,
  );
}
