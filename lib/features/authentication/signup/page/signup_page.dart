import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/core/constants/app_assets.dart';
import 'package:medi_slot/core/constants/app_routes.dart';
import 'package:medi_slot/features/authentication/signup/cubit/signup_cubit.dart';
import 'package:medi_slot/shared/widgets/error_dialog.dart';
import 'package:medi_slot/shared/widgets/loading_dialog.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../../../../shared/widgets/labeled_text_form_field.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  Column(
                    spacing: 20.h,
                    children: [
                      LabeledTextFormField(
                        label: AppStrings.name,
                        controller: cubit.nameController,
                        validator: cubit.validateName,
                        onChanged: (value) => _formKey.currentState?.validate(),
                      ),
                      LabeledTextFormField(
                        label: AppStrings.email,
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: cubit.validateEmail,
                        onChanged: (value) => _formKey.currentState?.validate(),
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
                            validator: cubit.validatePassword,
                            onChanged: (value) =>
                                _formKey.currentState?.validate(),
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
                            validator: cubit.validateConfirmPassword,
                            onChanged: (value) =>
                                _formKey.currentState?.validate(),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  BlocListener<SignupCubit, SignupState>(
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
                        if (_formKey.currentState!.validate()) {
                          await cubit.signupApiCall();
                        }
                      },
                    ),
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
                  Row(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
