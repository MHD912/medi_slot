import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../models/category_list_item.dart';
import '../models/recent_visit_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: 10.h),
          sliver: _pageHeader(context),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 24.h),
          sliver: _searchBar(context),
        ),
        SliverPadding(
          padding: EdgeInsetsDirectional.only(
            top: 10.h,
            start: 24.w,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              AppStrings.whatLookingFor,
              style: AppStyles.f20w700.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 10.h),
          sliver: _categoriesList(context),
        ),
        SliverPadding(
          padding: EdgeInsetsDirectional.only(
            top: 32.h,
            start: 24.w,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              AppStrings.doNotForget,
              style: AppStyles.f20w700.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 10.h),
          sliver: _comingAppointment(context),
        ),
        SliverPadding(
          padding: EdgeInsetsDirectional.only(
            top: 24.h,
            start: 24.w,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              AppStrings.recentVisit,
              style: AppStyles.f20w700.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
          sliver: _recentVisitsList(),
        ),
      ],
    );
  }

  Widget _pageHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.hello.tr()} John !",
                  style: AppStyles.f24w700.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  AppStrings.howDoYouFeel,
                  style: AppStyles.f14w400.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ).tr(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.greyColor,
                ),
              ),
              child: CircleAvatar(
                radius: 28.sp,
                foregroundImage: AssetImage(
                  AppAssets.raster.profilePicture,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    final focusNode = FocusNode();
    return SliverToBoxAdapter(
      child: Container(
        height: 48.h,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        child: TextFormField(
          focusNode: focusNode,
          controller: TextEditingController(),
          style: AppStyles.f16w400.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(start: 20.sp),
            suffixIcon: Padding(
              padding: EdgeInsets.all(5.sp),
              child: IconButton(
                onPressed: () => focusNode.requestFocus(),
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                icon: SvgPicture.asset(
                  AppAssets.scalable.search,
                  height: 24.sp,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoriesList(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryListItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.only(
                start: (index == 0) ? 20.w : 0,
                end: (index == categoryListItems.length - 1) ? 20.w : 0,
              ),
              child: categoryListItems[index],
            );
          },
        ),
      ),
    );
  }

  Widget _comingAppointment(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 135.h,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.greyColor,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 32.sp,
                    foregroundImage: AssetImage(
                      AppAssets.raster.person2,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.drAssaedHanash,
                      style: AppStyles.f20w700.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ).tr(),
                    Text(
                      "ENT",
                      style: AppStyles.f16w400.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 2.w,
                    children: [
                      SvgPicture.asset(
                        AppAssets.scalable.calendar,
                        height: 24.sp,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        "Wed 7 Sep 2024",
                        style: AppStyles.f14w400.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 2.w,
                    children: [
                      SvgPicture.asset(
                        AppAssets.scalable.timeClock,
                        height: 24.sp,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        "10:30 11:30 AM",
                        style: AppStyles.f14w400.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentVisitsList() {
    return SliverList.list(
      children: recentVisitsList,
    );
  }
}
