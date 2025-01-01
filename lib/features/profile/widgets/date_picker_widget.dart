import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_slot/features/profile/cubit/profile_cubit.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_styles.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10.w),
          child: Text(
            AppStrings.dateOfBirth,
            style: AppStyles.f16w400.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).tr(),
        ),
        Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Row(
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: Center(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    buildWhen: (_, currentState) => currentState is DateChanged,
                    builder: (context, state) {
                      return Text(
                        (cubit.selectedDate != null)
                            ? cubit.parseDate()
                            : "DD MM YYYY",
                        style: AppStyles.f16w400.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsetsDirectional.only(end: 5.w),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Material(
                    color: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          initialDate: DateTime.now(),
                        );
                        cubit.setSelectedDate = selectedDate;
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
