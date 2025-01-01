import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/theme/app_styles.dart';
import '../../../../core/utilities/verify_code_text_formatter.dart';
import '../cubit/verification_cubit.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VerificationCubit>(context);
    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) => Form(
        key: cubit.globalKey,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            length: 4,
            appContext: context,
            controller: cubit.codeController,
            animationType: AnimationType.scale,
            keyboardType: TextInputType.number,
            mainAxisAlignment: MainAxisAlignment.center,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            textStyle: AppStyles.f16w700.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            pastedTextStyle: AppStyles.f16w700.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            errorTextSpace: 25.h,
            cursorColor: Theme.of(context).colorScheme.primary,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(16.sp),
              borderWidth: 1.sp,
              fieldHeight: 48.h,
              fieldWidth: 50.w,
              activeColor: Theme.of(context).colorScheme.primary,
              activeFillColor: Theme.of(context).colorScheme.surface,
              inactiveColor: Theme.of(context).colorScheme.outline,
              inactiveFillColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).colorScheme.primary,
              selectedFillColor: Theme.of(context).colorScheme.surface,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            inputFormatters: [
              VerifyCodeTextFormatter(),
            ],
            validator: cubit.validator,
            beforeTextPaste: (text) => false,
            dialogConfig: DialogConfig(
              dialogContent: "Do you want to paste code?",
              affirmativeText: "paste",
              negativeText: "cancel",
              platform: PinCodePlatform.other,
            ),
            onTap: () {
              cubit.clearValidator();
              Future.delayed(
                const Duration(milliseconds: 100),
                () => cubit.globalKey.currentState!.validate(),
              );
            },
          ),
        ),
      ),
    );
  }
}
