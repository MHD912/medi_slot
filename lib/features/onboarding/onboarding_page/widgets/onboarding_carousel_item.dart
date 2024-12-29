import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_styles.dart';

class OnBoardingCarouselItem extends StatelessWidget {
  final String svgImage, title, description;
  const OnBoardingCarouselItem({
    super.key,
    required this.svgImage,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        SvgPicture.asset(
          svgImage,
          height: 271.h,
        ),
        Spacer(
          flex: 3,
        ),
        Column(
          spacing: 8.h,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.f32w700OnSurface(context),
            ).tr(),
            SizedBox(
              width: 273.w,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: AppStyles.f16w400OnSurface(context),
              ).tr(),
            ),
          ],
        ),
      ],
    );
  }
}
