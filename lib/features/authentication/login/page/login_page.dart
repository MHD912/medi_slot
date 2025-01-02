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
import '../cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    AppStrings.login,
                    style: AppStyles.f40w700.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ).tr(),
                ),
                SizedBox(
                  height: 80.h,
                ),
                _inputForm(context, cubit),
                SizedBox(
                  height: 5.h,
                ),
                _forgotPasswordButton(context),
                SizedBox(
                  height: 165.h,
                ),
                _loginButtonWidget(context, cubit),
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
                _loginOptionsRow(),
                _goToSignupWidget(context),
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

  Widget _inputForm(BuildContext context, LoginCubit cubit) {
    return Column(
      spacing: 20.h,
      children: [
        _emailField(context, cubit),
        _passwordField(cubit),
      ],
    );
  }

  Widget _emailField(BuildContext context, LoginCubit cubit) {
    return Form(
      key: cubit.emailFormKey,
      child: LabeledTextFormField(
        label: AppStrings.email,
        controller: cubit.emailController,
        keyboardType: TextInputType.emailAddress,
        validator: cubit.emailValidator,
        onTap: () => cubit.clearEmailValidation(),
      ),
    );
  }

  Widget _passwordField(LoginCubit cubit) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (_, currentState) => currentState is LoginTogglePassword,
      builder: (context, state) {
        return Form(
          key: cubit.passwordFormKey,
          child: LabeledTextFormField(
            label: AppStrings.password,
            controller: cubit.passwordController,
            obscureText: !cubit.isPasswordVisible,
            suffixOnPressed: () => cubit.togglePasswordVisibility(),
            validator: cubit.passwordValidator,
            onTap: () => cubit.clearPasswordValidation(),
          ),
        );
      },
    );
  }

  Widget _forgotPasswordButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => context.pushNamed(
            AppRoutes.forgotPassword,
          ),
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 5.w),
            ),
          ),
          child: Text(
            AppStrings.forgotPassword,
            style: AppStyles.f12w400.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).tr(),
        ),
      ],
    );
  }

  Widget _loginButtonWidget(BuildContext context, LoginCubit cubit) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (_, currentState) =>
          currentState is LoginLoading ||
          currentState is LoginSuccess ||
          currentState is LoginError,
      listener: (context, state) {
        if (state is LoginLoading) {
          LoadingDialog.show(context);
          return;
        }
        context.pop();
        if (state is LoginSuccess) {
          context.goNamed(AppRoutes.home);
        } else {
          ErrorDialog.show(context);
        }
      },
      child: CustomMaterialButton(
        label: AppStrings.login,
        onPressed: () async {
          if (cubit.validateInput()) {
            await BlocProvider.of<LoginCubit>(context).loginApiCall();
          }
        },
      ),
    );
  }

  Widget _loginOptionsRow() {
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

  Widget _goToSignupWidget(BuildContext context) {
    return Row(
      spacing: 2.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.doNotHaveAccount,
          style: AppStyles.f12w400.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ).tr(),
        TextButton(
          onPressed: () => context.pushReplacementNamed(
            AppRoutes.signup,
          ),
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            padding: WidgetStatePropertyAll(
              EdgeInsets.zero,
            ),
          ),
          child: Text(
            AppStrings.signup,
            style: AppStyles.f12w400.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ).tr(),
        ),
      ],
    );
  }
}
