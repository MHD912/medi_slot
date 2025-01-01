import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medi_slot/core/constants/app_strings.dart';
import 'package:medi_slot/core/theme/app_styles.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            child: Text(
              AppStrings.favorites,
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
