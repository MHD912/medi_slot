import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_styles.dart';

class LabeledTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool? obscureText;
  final void Function()? suffixOnPressed;
  const LabeledTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText,
    this.suffixOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10.w),
          child: Text(
            label,
            style: AppStyles.f16w400OnSurface(context),
          ).tr(),
        ),
        SizedBox(
          height: 48.h,
          child: TextFormField(
            controller: controller,
            // onTapOutside: (event) => FocusScope.of(context).unfocus(),
            obscureText: obscureText ?? false,
            style: AppStyles.f16w400OnSurface(context),
            decoration: InputDecoration(
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

                          // height: 18.sp,
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
