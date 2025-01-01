import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/features/authentication/verification/cubit/verification_cubit.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../widgets/custom_pin_code_text_field.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VerificationCubit>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      AppStrings.verification,
                      style: AppStyles.f32w700.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ).tr(),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: _verificationCodeSection(context, cubit),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      _enterCodeButtonWidget(context),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _verificationCodeSection(
    BuildContext context,
    VerificationCubit cubit,
  ) {
    return Column(
      children: [
        Spacer(flex: 9),
        Text(
          AppStrings.enterVerificationCode,
          textAlign: TextAlign.center,
          style: AppStyles.f16w400.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ).tr(),
        SizedBox(height: 5.h),
        CustomPinCodeTextField(),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.didNotReceiveCode,
              style: AppStyles.f12w400.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                padding: WidgetStatePropertyAll(
                  EdgeInsets.zero,
                ),
              ),
              child: Text(
                AppStrings.resend,
                style: AppStyles.f12w400.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ).tr(),
            ),
          ],
        ),
        Spacer(flex: 7),
      ],
    );
  }

  Widget _enterCodeButtonWidget(BuildContext context) {
    return CustomMaterialButton(
      label: AppStrings.enterCode,
      onPressed: () => context.pushNamed(
        AppRoutes.changePassword,
      ),
    );
  }
}
