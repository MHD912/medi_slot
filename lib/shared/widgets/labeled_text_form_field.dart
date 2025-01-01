import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_styles.dart';

class LabeledTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool? obscureText;
  final void Function()? suffixOnPressed;
  final TextInputType? keyboardType;
  final bool isProfilePage;
  const LabeledTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText,
    this.suffixOnPressed,
    this.keyboardType,
    this.isProfilePage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: (isProfilePage) ? 0 : 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10.w),
          child: Text(
            label,
            style: AppStyles.f16w400.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).tr(),
        ),
        SizedBox(
          height: 48.h,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            style: AppStyles.f16w400.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.only(start: 15.sp),
              suffixIcon: (obscureText == null)
                  ? null
                  : Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: IconButton(
                        onPressed: suffixOnPressed,
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          (obscureText!)
                              ? AppAssets.scalable.visibilityOff
                              : AppAssets.scalable.visibilityOn,
                          height: (obscureText!) ? 18.sp : 30.sp,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
