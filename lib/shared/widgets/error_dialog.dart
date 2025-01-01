import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_styles.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => ErrorDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: Text(
        AppStrings.errorOccurred,
        style: AppStyles.f24w700.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ).tr(),
    );
  }
}
