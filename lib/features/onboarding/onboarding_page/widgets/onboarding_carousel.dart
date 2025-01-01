import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/onboarding_cubit.dart';
import 'onboarding_carousel_item.dart';

class OnboardingCarousel extends StatelessWidget {
  final List<OnBoardingCarouselItem> onboardingSlides;
  const OnboardingCarousel({
    super.key,
    required this.onboardingSlides,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);

    final carouselProgressIcons = List<Widget>.generate(
      onboardingSlides.length,
      (index) => BlocBuilder<OnboardingCubit, OnboardingState>(
        buildWhen: (_, currentState) => currentState is OnboardingNext,
        builder: (context, state) {
          return Icon(
            Icons.circle,
            size: 12.sp,
            color: (index <= cubit.index)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          );
        },
      ),
    );

    return Column(
      children: [
        Expanded(
          flex: 12,
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            buildWhen: (_, currentState) => currentState is OnboardingNext,
            builder: (context, state) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: onboardingSlides[cubit.index],
            ),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 2,
          child: Row(
            spacing: 5.sp,
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselProgressIcons,
          ),
        ),
      ],
    );
  }
}
