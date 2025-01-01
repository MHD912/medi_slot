import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../cubit/hub_cubit.dart';

class HubBottomNavBar extends StatelessWidget {
  const HubBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HubCubit>(context);
    return BlocBuilder<HubCubit, HubState>(
      buildWhen: (_, currentState) => currentState is NavBarChange,
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.grey.withValues(alpha: 0.2),
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: cubit.pageIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            onTap: (newValue) => cubit.pageIndex = newValue,
            items: [
              BottomNavigationBarItem(
                label: 'home',
                icon: Padding(
                  padding: EdgeInsetsDirectional.only(start: 20.w),
                  child: _svgIcon(
                    context,
                    assetName: AppAssets.scalable.home,
                    isSelected: cubit.pageIndex == 0,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'schedule',
                icon: Padding(
                  padding: EdgeInsetsDirectional.only(start: 5.w),
                  child: _svgIcon(
                    context,
                    assetName: AppAssets.scalable.calendar,
                    isSelected: cubit.pageIndex == 1,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'favorites',
                icon: Padding(
                  padding: EdgeInsetsDirectional.only(end: 5.w),
                  child: _svgIcon(
                    context,
                    assetName: AppAssets.scalable.favorite,
                    isSelected: cubit.pageIndex == 2,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'notifications',
                icon: Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.w),
                  child: _svgIcon(
                    context,
                    assetName: AppAssets.scalable.bell,
                    isSelected: cubit.pageIndex == 3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SvgPicture _svgIcon(
    BuildContext context, {
    required String assetName,
    required bool isSelected,
  }) {
    return SvgPicture.asset(
      assetName,
      height: 20.h,
      colorFilter: ColorFilter.mode(
        (isSelected)
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimaryContainer,
        BlendMode.srcIn,
      ),
    );
  }
}
