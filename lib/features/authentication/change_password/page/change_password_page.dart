import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/features/authentication/change_password/cubit/change_password_cubit.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../../../../shared/widgets/labeled_text_form_field.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
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
                      AppStrings.enterNewPassword,
                      style: AppStyles.f32w700.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ).tr(),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: _formSection(
                    context,
                    cubit: cubit,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      _continueButtonWidget(context),
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

  Widget _formSection(
    BuildContext context, {
    required ChangePasswordCubit cubit,
  }) {
    return Column(
      children: [
        Spacer(flex: 8),
        BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          buildWhen: (_, currentState) =>
              currentState is ChangePasswordTogglePassword,
          builder: (context, state) {
            return LabeledTextFormField(
              label: AppStrings.password,
              controller: cubit.passwordController,
              obscureText: !cubit.isPasswordVisible,
              suffixOnPressed: () => cubit.togglePasswordVisibility(),
            );
          },
        ),
        Spacer(flex: 3),
        BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          buildWhen: (_, currentState) =>
              currentState is ChangePasswordToggleConfirmPassword,
          builder: (context, state) {
            return LabeledTextFormField(
              label: AppStrings.confirmPassword,
              controller: cubit.confirmPasswordController,
              obscureText: !cubit.isConfirmPasswordVisible,
              suffixOnPressed: () => cubit.toggleConfirmPasswordVisibility(),
            );
          },
        ),
        Spacer(flex: 7),
      ],
    );
  }

  Widget _continueButtonWidget(BuildContext context) {
    return CustomMaterialButton(
      label: AppStrings.continueText,
      onPressed: () => context.goNamed(
        AppRoutes.login,
      ),
    );
  }
}
