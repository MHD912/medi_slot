import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listenWhen: (_, currentState) => currentState is SplashEnd,
        listener: (context, state) {
          state as SplashEnd;
          context.goNamed(state.routeName);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SvgPicture.asset(
              AppAssets.scalable.appLogo,
              width: 193.w,
              height: 93.h,
            ),
          ),
        ),
      ),
    );
  }
}
