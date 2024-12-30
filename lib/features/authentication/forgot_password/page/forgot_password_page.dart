import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/core/constants/app_routes.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../shared/widgets/custom_material_button.dart';
import '../../../../shared/widgets/labeled_text_form_field.dart';
import '../cubit/forgot_password_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
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
                      AppStrings.forgotPassword,
                      style: AppStyles.f32w700OnSurface(context),
                    ).tr(),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: _emailField(cubit),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      _sendButtonWidget(context),
                      Spacer(),
                      Text(
                        AppStrings.or,
                        style: AppStyles.f16w700.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ).tr(),
                      SizedBox(
                        height: 10.h,
                      ),
                      _loginOptionsRow(),
                      Spacer(flex: 2),
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

  Widget _emailField(ForgotPasswordCubit cubit) {
    return Column(
      children: [
        Spacer(flex: 7),
        LabeledTextFormField(
          label: AppStrings.email,
          controller: cubit.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        Spacer(flex: 6),
      ],
    );
  }

  Widget _sendButtonWidget(BuildContext context) {
    return CustomMaterialButton(
      label: AppStrings.sendCode,
      onPressed: () => context.pushNamed(
        AppRoutes.verification.name,
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
}
