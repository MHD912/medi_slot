import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_slot/core/constants/app_assets.dart';
import 'package:medi_slot/features/authentication/signup/cubit/signup_cubit.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../../../../shared/widgets/labeled_text_form_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: Text(
                    AppStrings.signup,
                    style: AppStyles.f40w700OnSurface(context),
                  ).tr(),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Column(
                  spacing: 20.h,
                  children: [
                    LabeledTextFormField(
                      label: AppStrings.name,
                      controller: cubit.nameController,
                    ),
                    LabeledTextFormField(
                      label: AppStrings.email,
                      controller: cubit.emailController,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      buildWhen: (_, currentState) =>
                          currentState is SignupTogglePassword,
                      builder: (context, state) {
                        return LabeledTextFormField(
                          label: AppStrings.password,
                          controller: cubit.passwordController,
                          obscureText: !cubit.isPasswordVisible,
                          suffixOnPressed: () =>
                              cubit.togglePasswordVisibility(),
                        );
                      },
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      buildWhen: (_, currentState) =>
                          currentState is SignupToggleConfirmPassword,
                      builder: (context, state) {
                        return LabeledTextFormField(
                          label: AppStrings.confirmPassword,
                          controller: cubit.confirmPasswordController,
                          obscureText: !cubit.isConfirmPasswordVisible,
                          suffixOnPressed: () =>
                              cubit.toggleConfirmPasswordVisibility(),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 36.h,
                ),
                CustomMaterialButton(
                  label: AppStrings.signup,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 38.h,
                ),
                Text(
                  AppStrings.or,
                  style: AppStyles.f16w700.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ).tr(),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  spacing: 5.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        AppAssets.scalable.facebook,
                        height: 28.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        AppAssets.scalable.googleChrome,
                        height: 28.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        AppAssets.scalable.twitter,
                        height: 28.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.haveAccount,
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
                        AppStrings.login,
                        style: AppStyles.f12w400.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
