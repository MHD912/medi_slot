import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_preferences.dart';
import '../../../core/utilities/global_variables.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _preferences;
  late ThemeMode _themeMode;

  ThemeCubit(
    this._preferences,
    this._themeMode,
  ) : super(
          ThemeInitial(themeMode: _themeMode),
        );

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await _preferences.setBool(AppPreferences.isDarkMode, isDark);
    emit(
      ThemeChanged(themeMode: _themeMode),
    );
  }

  Future<void> toggleThemeMode() async {
    final isDarkMode = _themeMode == ThemeMode.dark;
    _themeMode = (isDarkMode) ? ThemeMode.light : ThemeMode.dark;
    await _preferences.setBool(AppPreferences.isDarkMode, !isDarkMode);
    emit(
      ThemeChanged(themeMode: _themeMode),
    );
  }

  static Future<ThemeCubit> init() async {
    ThemeMode themeMode;
    final preferences = getIt.get<SharedPreferences>();
    var isDarkMode = preferences.getBool(AppPreferences.isDarkMode);
    if (isDarkMode == null) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDarkMode = (brightness == Brightness.dark);
      await preferences.setBool(AppPreferences.isDarkMode, isDarkMode);
    }
    themeMode = (isDarkMode) ? ThemeMode.dark : ThemeMode.light;
    return ThemeCubit(preferences, themeMode);
  }
}
