import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_styles.dart';

class CustomMaterialButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color? color;
  final TextStyle? labelStyle;

  const CustomMaterialButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 48.h,
      minWidth: 328.w,
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      color: color ?? Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: labelStyle ??
            AppStyles.f16w700.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ).tr(),
    );
  }
}
