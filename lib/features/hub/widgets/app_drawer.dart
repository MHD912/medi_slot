import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_locals.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../shared/localization/cubit/localization_cubit.dart';
import '../../../shared/theme/cubit/theme_cubit.dart';
import '../../../shared/widgets/error_dialog.dart';
import '../../../shared/widgets/loading_dialog.dart';
import '../cubit/hub_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localeCubit = BlocProvider.of<LocalizationCubit>(context);
    return Drawer(
      width: 188.w,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(8.sp),
          bottomStart: Radius.circular(8.sp),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 64.h),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.greyColor,
              ),
            ),
            child: CircleAvatar(
              radius: 40.sp,
              foregroundImage: AssetImage(
                AppAssets.raster.profilePicture,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            "John Doh",
            style: AppStyles.f20w700.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 64.h),
          Column(
            children: [
              _listItemButton(
                context,
                label: AppStrings.settings,
                onPressed: () => context.pushNamed(AppRoutes.profile),
              ),
              BlocBuilder<ThemeCubit, ThemeState>(
                buildWhen: (_, currentState) => currentState is ThemeChanged,
                builder: (context, state) {
                  return _listItemButton(
                    context,
                    label: (state.themeMode == ThemeMode.light)
                        ? AppStrings.darkMode
                        : AppStrings.lightMode,
                    onPressed: () async {
                      await BlocProvider.of<ThemeCubit>(context)
                          .toggleThemeMode();
                    },
                  );
                },
              ),
              _listItemButton(
                context,
                label: (localeCubit.activeLocale == AppLocals.englishLocal)
                    ? AppStrings.arabic
                    : AppStrings.english,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: LoadingDialog(),
                    ),
                  );
                  await Future.delayed(const Duration(milliseconds: 500));
                  if (!context.mounted) return;
                  await context.setLocale(
                    (localeCubit.activeLocale == AppLocals.englishLocal)
                        ? AppLocals.arabicLocal
                        : AppLocals.englishLocal,
                  );
                  await localeCubit.toggleLocale();
                  if (!context.mounted) return;
                  context.goNamed(AppRoutes.splashScreen);
                },
              ),
              _listItemButton(
                context,
                label: AppStrings.aboutUs,
                onPressed: () {},
              ),
            ],
          ),
          Spacer(),
          _logoutButton(context),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _listItemButton(
    BuildContext context, {
    required String label,
    required void Function() onPressed,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsetsDirectional.only(end: 24.w),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Text(
          label,
          style: AppStyles.f16w400.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ).tr(),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return BlocListener<HubCubit, HubState>(
      listenWhen: (_, current) =>
          current is LogoutLoading ||
          current is LogoutSuccess ||
          current is LogoutError,
      listener: (context, state) {
        if (state is LogoutLoading) {
          LoadingDialog.show(context);
          return;
        }
        context.pop();
        if (state is LogoutSuccess) {
          context.goNamed(AppRoutes.welcome);
        } else {
          ErrorDialog.show(context);
        }
      },
      child: MaterialButton(
        onPressed: () async {
          await BlocProvider.of<HubCubit>(context).logoutApiCall();
        },
        padding: EdgeInsetsDirectional.only(end: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              AppAssets.scalable.leaveDoor,
              height: 19.h,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              AppStrings.logout,
              style: AppStyles.f16w400.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
