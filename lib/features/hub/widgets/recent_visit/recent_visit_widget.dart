import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_slot/core/constants/app_assets.dart';
import 'package:medi_slot/core/theme/app_styles.dart';
import 'package:medi_slot/features/hub/widgets/recent_visit/cubit/recent_visit_cubit.dart';

class RecentVisitWidget extends StatelessWidget {
  final String assetName, doctorName;
  final double rating, price;
  const RecentVisitWidget({
    super.key,
    required this.assetName,
    required this.doctorName,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.h,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 100.w,
            height: 103.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  assetName,
                ),
              ),
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: AppStyles.f20w700.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ).tr(),
                        Text(
                          "ENT",
                          style: AppStyles.f16w400.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<RecentVisitCubit>(context)
                              .toggleFavorite();
                        },
                        child: BlocBuilder<RecentVisitCubit, RecentVisitState>(
                          builder: (context, state) {
                            return SvgPicture.asset(
                              (state.isFavorite)
                                  ? AppAssets.scalable.favoriteFilled
                                  : AppAssets.scalable.favorite,
                              height: 20.h,
                              colorFilter: ColorFilter.mode(
                                (state.isFavorite)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                BlendMode.srcIn,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 4.w,
                      children: [
                        SvgPicture.asset(
                          AppAssets.scalable.star,
                          height: 19.h,
                        ),
                        Text(
                          rating.toString(),
                          style: AppStyles.f16w400.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                    Text(
                      "\$$price/hr",
                      style: AppStyles.f16w400.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
