import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_locals.dart';
import '../../../core/constants/app_preferences.dart';
import '../../../core/utilities/global_variables.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final SharedPreferences _preferences;
  late Locale _activeLocale;

  LocalizationCubit(
    this._preferences,
    this._activeLocale,
  ) : super(
          LocalizationInitial(
            locale: _activeLocale,
          ),
        );

  Locale get activeLocale => _activeLocale;

  Future<void> setLocale(Locale newLocal) async {
    _activeLocale = newLocal;
    await _preferences.setString(
      AppPreferences.local,
      newLocal.languageCode,
    );
    emit(
      LocaleChanged(locale: newLocal),
    );
  }

  Future<void> toggleLocale() async {
    _activeLocale = (_activeLocale == AppLocals.englishLocal)
        ? AppLocals.arabicLocal
        : AppLocals.englishLocal;
    await _preferences.setString(
      AppPreferences.local,
      _activeLocale.languageCode,
    );
    emit(
      LocaleChanged(locale: _activeLocale),
    );
  }

  static Future<LocalizationCubit> init() async {
    final Locale local;
    final preferences = getIt.get<SharedPreferences>();
    var languageCode = preferences.getString(AppPreferences.local);
    if (languageCode == null) {
      final languageCode = PlatformDispatcher.instance.locale.languageCode;
      local = (languageCode == 'en')
          ? AppLocals.englishLocal
          : AppLocals.arabicLocal;
      await preferences.setString(AppPreferences.local, languageCode);
    } else {
      local = (languageCode == 'en')
          ? AppLocals.englishLocal
          : AppLocals.arabicLocal;
    }
    return LocalizationCubit(preferences, local);
  }
}
