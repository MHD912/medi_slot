import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_preferences.dart';
import '../../../../core/utilities/global_variables.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final _preferences = getIt.get<SharedPreferences>();

  int index = 0;
  int lastSlideIndex = 1;

  bool isLastSlide() => index == lastSlideIndex;

  void skipSlides() {
    emit(OnboardingSkip());
  }

  void nextSlide() {
    if (index < lastSlideIndex) {
      index++;
      emit(OnboardingNext());
    } else {
      emit(OnboardingGetStarted());
    }
  }

  // Update cache `is_first` key to `false`, so that the onboarding page doesn't show up anymore.
  void invalidateFirstTimeLaunch() {
    _preferences.setBool(AppPreferences.isFirst, false);
  }
}
