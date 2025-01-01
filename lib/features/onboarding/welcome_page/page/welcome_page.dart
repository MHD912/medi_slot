import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/core/constants/app_routes.dart';
import 'package:medi_slot/core/constants/app_strings.dart';
import 'package:medi_slot/core/theme/app_styles.dart';
import 'package:medi_slot/shared/widgets/custom_material_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                AppStrings.welcome,
                style: AppStyles.f40w700.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ).tr(),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 24.h,
              children: [
                _signupButtonWidget(context),
                _loginButtonWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomMaterialButton _signupButtonWidget(BuildContext context) {
    return CustomMaterialButton(
      label: AppStrings.signup,
      onPressed: () => context.pushNamed(AppRoutes.signup),
    );
  }

  CustomMaterialButton _loginButtonWidget(BuildContext context) {
    return CustomMaterialButton(
      label: AppStrings.login,
      onPressed: () => context.pushNamed(AppRoutes.login),
      color: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: AppStyles.f16w700.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
