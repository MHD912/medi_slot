import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_carousel.dart';
import '../widgets/onboarding_carousel_item.dart';
import '../widgets/skip_button_widget.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final onboardingSlides = <OnBoardingCarouselItem>[
    OnBoardingCarouselItem(
      svgImage: AppAssets.scalable.onboarding1,
      title: AppStrings.onlineHealthCheck,
      description: AppStrings.bookTheBestDoctor,
    ),
    OnBoardingCarouselItem(
      svgImage: AppAssets.scalable.onboarding2,
      title: AppStrings.nearToYou,
      description: AppStrings.scheduleYourVisit,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (_, currentState) =>
          currentState is OnboardingGetStarted ||
          currentState is OnboardingSkip,
      listener: (context, state) {
        cubit.invalidateFirstTimeLaunch();
        context.pushReplacementNamed(AppRoutes.welcome.name);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SkipButtonWidget(),
                ],
              ),
              Spacer(),
              Expanded(
                flex: 14,
                child: OnboardingCarousel(
                  onboardingSlides: onboardingSlides,
                ),
              ),
              _primaryButton(context),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _primaryButton(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (_, currentState) => currentState is OnboardingNext,
      builder: (context, state) {
        return CustomMaterialButton(
          label:
              (cubit.isLastSlide()) ? AppStrings.getStarted : AppStrings.next,
          onPressed: () => cubit.nextSlide(),
        );
      },
    );
  }
}
