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
          routeName: AppRoutes.onboarding.name,
        ),
      );
      return;
    }

    final isLoggedIn = preferences.getBool(AppPreferences.isLoggedIn);
    if (isLoggedIn == true) {
      emit(
        SplashEnd(
          routeName: AppRoutes.home.name,
        ),
      );
    } else {
      emit(
        SplashEnd(
          routeName: AppRoutes.welcome.name,
        ),
      );
    }
  }
}
