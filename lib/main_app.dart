import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utilities/global_variables.dart';
import 'shared/localization/cubit/localization_cubit.dart';
import 'shared/theme/cubit/theme_cubit.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt.get<ThemeCubit>(),
        ),
        BlocProvider.value(
          value: getIt.get<LocalizationCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          buildWhen: (_, current) => current is LocaleChanged,
          builder: (context, localeState) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) => MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: localeState.locale,
                theme: AppTheme.lightTheme(context.locale),
                darkTheme: AppTheme.darkTheme(context.locale),
                themeMode: themeState.themeMode,
                routerConfig: AppRouter.goRouter,
              ),
            );
          },
        ),
      ),
    );
  }
}
