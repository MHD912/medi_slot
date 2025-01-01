import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.greyColor,
            ),
          ),
          child: CircleAvatar(
            radius: 50.sp,
            foregroundImage: AssetImage(
              AppAssets.raster.profilePicture,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: -2,
          child: Material(
            color: Colors.transparent,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.add_circle_outline,
                size: 28.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        )
      ],
    );
  }
}
