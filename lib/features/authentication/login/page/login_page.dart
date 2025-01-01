import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/shared/widgets/error_dialog.dart';
import 'package:medi_slot/shared/widgets/loading_dialog.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../../../../shared/widgets/labeled_text_form_field.dart';
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
                _inputForm(cubit),
                SizedBox(
                  height: 5.h,
                ),
                _forgotPasswordButton(context),
                SizedBox(
                  height: 165.h,
                ),
                _loginButtonWidget(context),
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

  Widget _inputForm(LoginCubit cubit) {
    return Column(
      spacing: 20.h,
      children: [
        _emailField(cubit),
        _passwordField(cubit),
      ],
    );
  }

  Widget _emailField(LoginCubit cubit) {
    return LabeledTextFormField(
      label: AppStrings.email,
      controller: cubit.emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField(LoginCubit cubit) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (_, currentState) => currentState is LoginTogglePassword,
      builder: (context, state) {
        return LabeledTextFormField(
          label: AppStrings.password,
          controller: cubit.passwordController,
          obscureText: !cubit.isPasswordVisible,
          suffixOnPressed: () => cubit.togglePasswordVisibility(),
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

  Widget _loginButtonWidget(BuildContext context) {
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
          await BlocProvider.of<LoginCubit>(context).loginApiCall();
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
