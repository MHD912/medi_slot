import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle f16w400OnSurface(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle f16w700(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle f32w700OnSurface(BuildContext context) => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle f40w700OnSurface(BuildContext context) => TextStyle(
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      );
}
