import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_slot/features/hub/widgets/recent_visit/cubit/recent_visit_cubit.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/recent_visit/recent_visit_widget.dart';

final List<Widget> recentVisitsList = [
  BlocProvider<RecentVisitCubit>(
    create: (context) => RecentVisitCubit(),
    child: RecentVisitWidget(
      assetName: AppAssets.raster.person3,
      doctorName: AppStrings.drNourSrour,
      price: 25,
      rating: 4.9,
    ),
  ),
  BlocProvider<RecentVisitCubit>(
    create: (context) => RecentVisitCubit(),
    child: RecentVisitWidget(
      assetName: AppAssets.raster.person2,
      doctorName: AppStrings.drAssaed,
      price: 20,
      rating: 4.0,
    ),
  ),
  BlocProvider<RecentVisitCubit>(
    create: (context) => RecentVisitCubit(),
    child: RecentVisitWidget(
      assetName: AppAssets.raster.person1,
      doctorName: AppStrings.drAmaniAlbij,
      price: 55,
      rating: 3.5,
    ),
  ),
];
