import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';

class CategoryWidget extends StatelessWidget {
  final String assetName, categoryName;
  final void Function() onPressed;
  const CategoryWidget({
    super.key,
    required this.assetName,
    required this.categoryName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80.sp,
            width: 80.sp,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: AppColors.greyColor,
              ),
              image: DecorationImage(
                image: AssetImage(
                  assetName,
                ),
              ),
            ),
          ),
          Text(
            categoryName,
            style: AppStyles.f16w400.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
