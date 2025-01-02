import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../../../../shared/widgets/error_dialog.dart';
import '../../../../shared/widgets/labeled_text_form_field.dart';
import '../../../../shared/widgets/loading_dialog.dart';
import '../cubit/signup_cubit.dart';

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
                    style: AppStyles.f40w700.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ).tr(),
                ),
                SizedBox(
                  height: 32.h,
                ),
                _inputForm(cubit),
                SizedBox(
                  height: 36.h,
                ),
                _signupButton(cubit),
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
                _signupOptionsRow(),
                _goToLoginWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputForm(SignupCubit cubit) {
    return Column(
      spacing: 20.h,
      children: [
        _nameField(cubit),
        _emailField(cubit),
        _passwordField(cubit),
        _confirmPasswordField(cubit),
      ],
    );
  }

  Widget _nameField(SignupCubit cubit) {
    return Form(
      key: cubit.nameFormKey,
      child: LabeledTextFormField(
        label: AppStrings.name,
        controller: cubit.nameController,
        validator: cubit.validateName,
        onTap: () => cubit.clearNameValidation(),
      ),
    );
  }

  Widget _emailField(SignupCubit cubit) {
    return Form(
      key: cubit.emailFormKey,
      child: LabeledTextFormField(
        label: AppStrings.email,
        controller: cubit.emailController,
        keyboardType: TextInputType.emailAddress,
        validator: cubit.validateEmail,
        onTap: () => cubit.clearEmailValidation(),
      ),
    );
  }

  Widget _passwordField(SignupCubit cubit) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (_, currentState) => currentState is SignupTogglePassword,
      builder: (context, state) {
        return Form(
          key: cubit.passwordFormKey,
          child: LabeledTextFormField(
            label: AppStrings.password,
            controller: cubit.passwordController,
            obscureText: !cubit.isPasswordVisible,
            suffixOnPressed: () => cubit.togglePasswordVisibility(),
            validator: cubit.validatePassword,
            onTap: () => cubit.clearPasswordValidation(),
          ),
        );
      },
    );
  }

  Widget _confirmPasswordField(SignupCubit cubit) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (_, currentState) =>
          currentState is SignupToggleConfirmPassword,
      builder: (context, state) {
        return Form(
          key: cubit.confirmPasswordFormKey,
          child: LabeledTextFormField(
            label: AppStrings.confirmPassword,
            controller: cubit.confirmPasswordController,
            obscureText: !cubit.isConfirmPasswordVisible,
            suffixOnPressed: () => cubit.toggleConfirmPasswordVisibility(),
            validator: cubit.validateConfirmPassword,
            onTap: () => cubit.clearConfirmPasswordValidation(),
          ),
        );
      },
    );
  }

  Widget _signupButton(SignupCubit cubit) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (_, currentState) =>
          currentState is SignupLoading ||
          currentState is SignupSuccess ||
          currentState is SignupError,
      listener: (context, state) {
        if (state is SignupLoading) {
          LoadingDialog.show(context);
          return;
        }
        context.pop();
        if (state is SignupSuccess) {
          context.goNamed(AppRoutes.login);
        } else {
          ErrorDialog.show(context);
        }
      },
      child: CustomMaterialButton(
        label: AppStrings.signup,
        onPressed: () async {
          if (cubit.validateInput()) {
            await cubit.signupApiCall();
          }
        },
      ),
    );
  }

  Widget _signupOptionsRow() {
    return Row(
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
    );
  }

  Widget _goToLoginWidget(BuildContext context) {
    return Row(
      spacing: 2.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.haveAccount,
          style: AppStyles.f12w400.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ).tr(),
        TextButton(
          onPressed: () => context.pushReplacementNamed(
            AppRoutes.login,
          ),
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
    );
  }
}
