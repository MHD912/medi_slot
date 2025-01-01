import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medi_slot/core/constants/app_locals.dart';
import 'package:medi_slot/shared/localization/cubit/localization_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_app.dart';
import 'core/utilities/global_variables.dart';
import 'shared/theme/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initSingletons();
  runApp(
    EasyLocalization(
      supportedLocales: [
        AppLocals.englishLocal,
        AppLocals.arabicLocal,
      ],
      path: 'assets/translations',
      fallbackLocale: AppLocals.englishLocal,
      child: const MainApp(),
    ),
  );
}

Future<void> initSingletons() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  getIt.registerSingleton<ThemeCubit>(
    await ThemeCubit.init(),
  );
  getIt.registerSingleton<LocalizationCubit>(
    await LocalizationCubit.init(),
  );
}
