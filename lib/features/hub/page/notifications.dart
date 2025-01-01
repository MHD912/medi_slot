import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_styles.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            child: Text(
              AppStrings.notifications,
              style: AppStyles.f32w700.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            child: Text(
              AppStrings.comingSoon,
              style: AppStyles.f16w400.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
          ),
        ),
      ],
    );
  }
}
