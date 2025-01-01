import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_preferences.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/utilities/global_variables.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    startTimer();
  }

  void startTimer() {
    Timer(
      const Duration(seconds: 3),
      () async => await nextPage(),
    );
  }

  Future<void> nextPage() async {
    final preferences = getIt.get<SharedPreferences>();

    final isFirstLaunch = preferences.getBool(AppPreferences.isFirst);
    if (isFirstLaunch != false) {
      emit(
        SplashEnd(
          routeName: AppRoutes.onboarding,
        ),
      );
      return;
    }

    final token = preferences.getString(AppPreferences.token);
    if (token == null) {
      emit(
        SplashEnd(
          routeName: AppRoutes.welcome,
        ),
      );
    } else {
      emit(
        SplashEnd(
          routeName: AppRoutes.home,
        ),
      );
    }
  }
}
