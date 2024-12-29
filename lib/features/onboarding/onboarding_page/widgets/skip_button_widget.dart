import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../cubit/onboarding_cubit.dart';

class SkipButtonWidget extends StatelessWidget {
  const SkipButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return Container(
      height: 45.h,
      padding: EdgeInsets.all(5.sp),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        buildWhen: (_, currentState) => currentState is OnboardingNext,
        builder: (context, state) {
          return Visibility(
            visible: !cubit.isLastSlide(),
            child: TextButton(
              onPressed: () {
                cubit.skipSlides();
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.zero,
                ),
              ),
              child: Text(
                AppStrings.skip,
                style: AppStyles.f16w400OnSurface(context),
              ).tr(),
            ),
          );
        },
      ),
    );
  }
}
