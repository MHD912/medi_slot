import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/core/constants/app_strings.dart';
import 'package:medi_slot/core/theme/app_styles.dart';
import 'package:medi_slot/features/profile/cubit/profile_cubit.dart';
import 'package:medi_slot/shared/widgets/custom_material_button.dart';
import 'package:medi_slot/shared/widgets/labeled_text_form_field.dart';

import '../widgets/date_picker_widget.dart';
import '../widgets/profile_picture.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 28.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 64.h),
              ProfilePicture(),
              SizedBox(height: 58.h),
              LabeledTextFormField(
                label: AppStrings.editName,
                controller: cubit.nameController,
                isProfilePage: true,
              ),
              SizedBox(height: 20.h),
              DatePickerWidget(),
              SizedBox(height: 20.h),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (_, currentState) => currentState is GenderChanged,
                builder: (context, state) {
                  return Row(
                    spacing: 4.w,
                    children: [
                      Expanded(
                        child: _genderWidget(
                          context,
                          cubit,
                          gender: AppStrings.male,
                          isSelected: cubit.isMale,
                        ),
                      ),
                      Expanded(
                        child: _genderWidget(
                          context,
                          cubit,
                          gender: AppStrings.female,
                          isSelected: !cubit.isMale,
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(height: 20.h),
              LabeledTextFormField(
                label: AppStrings.editEmail,
                controller: cubit.emailController,
                keyboardType: TextInputType.emailAddress,
                isProfilePage: true,
              ),
              SizedBox(height: 20.h),
              LabeledTextFormField(
                label: AppStrings.phoneNumber,
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                isProfilePage: true,
              ),
              SizedBox(height: 60.h),
              CustomMaterialButton(
                label: AppStrings.save,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderWidget(
    BuildContext context,
    ProfileCubit cubit, {
    required String gender,
    required bool isSelected,
  }) {
    return MaterialButton(
      onPressed: cubit.toggleGender,
      height: 48.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Row(
        spacing: 5.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            (isSelected) ? Icons.circle : Icons.circle_outlined,
            size: 13.sp,
            color: (isSelected)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
          Text(
            gender,
            style: AppStyles.f16w400.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).tr()
        ],
      ),
    );
  }
}
