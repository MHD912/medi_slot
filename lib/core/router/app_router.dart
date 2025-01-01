import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_slot/features/authentication/change_password/cubit/change_password_cubit.dart';
import 'package:medi_slot/features/authentication/change_password/page/change_password_page.dart';
import 'package:medi_slot/features/authentication/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:medi_slot/features/authentication/forgot_password/page/forgot_password_page.dart';
import 'package:medi_slot/features/authentication/login/cubit/login_cubit.dart';
import 'package:medi_slot/features/authentication/login/page/login_page.dart';
import 'package:medi_slot/features/authentication/signup/cubit/signup_cubit.dart';
import 'package:medi_slot/features/authentication/signup/page/signup_page.dart';
import 'package:medi_slot/features/authentication/verification/cubit/verification_cubit.dart';
import 'package:medi_slot/features/authentication/verification/page/verification_page.dart';
import 'package:medi_slot/features/hub/cubit/hub_cubit.dart';
import 'package:medi_slot/features/profile/cubit/profile_cubit.dart';
import 'package:medi_slot/features/profile/page/profile_page.dart';
import 'package:medi_slot/features/splash/cubit/splash_cubit.dart';

import '../../features/hub/page/hub_page.dart';
import '../../features/onboarding/onboarding_page/cubit/onboarding_cubit.dart';
import '../../features/onboarding/onboarding_page/page/onboarding_page.dart';
import '../../features/onboarding/welcome_page/page/welcome_page.dart';
import '../../features/splash/page/splash_screen.dart';
import '../constants/app_routes.dart';
import '../utilities/transition_factory.dart';

class AppRouter {
  static final goRouter = GoRouter(
    initialLocation: '/${AppRoutes.splashScreen}',
    routes: <RouteBase>[
      GoRoute(
        path: '/${AppRoutes.splashScreen}',
        name: AppRoutes.splashScreen,
        builder: (context, state) {
          return BlocProvider<SplashCubit>(
            create: (context) => SplashCubit(),
            child: const SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: '/${AppRoutes.onboarding}',
        name: AppRoutes.onboarding,
        pageBuilder: TransitionFactory.fadingPageBuilder(
          child: BlocProvider<OnboardingCubit>(
            create: (context) => OnboardingCubit(),
            child: OnboardingPage(),
          ),
        ),
      ),
      GoRoute(
        path: '/${AppRoutes.welcome}',
        name: AppRoutes.welcome,
        pageBuilder: TransitionFactory.slidingPageBuilder(
          child: const WelcomePage(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.signup,
            name: AppRoutes.signup,
            pageBuilder: TransitionFactory.slidingPageBuilder(
              child: BlocProvider<SignupCubit>(
                create: (context) => SignupCubit(),
                child: const SignupPage(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.login,
            name: AppRoutes.login,
            pageBuilder: TransitionFactory.slidingPageBuilder(
              child: BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(),
                child: const LoginPage(),
              ),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.forgotPassword,
                name: AppRoutes.forgotPassword,
                pageBuilder: TransitionFactory.slidingPageBuilder(
                  child: BlocProvider<ForgotPasswordCubit>(
                    create: (context) => ForgotPasswordCubit(),
                    child: const ForgotPasswordPage(),
                  ),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: AppRoutes.verification,
                    name: AppRoutes.verification,
                    pageBuilder: TransitionFactory.slidingPageBuilder(
                      child: BlocProvider<VerificationCubit>(
                        create: (context) => VerificationCubit(),
                        child: const VerificationPage(),
                      ),
                    ),
                    routes: <RouteBase>[
                      GoRoute(
                        path: AppRoutes.changePassword,
                        name: AppRoutes.changePassword,
                        pageBuilder: TransitionFactory.slidingPageBuilder(
                          child: BlocProvider<ChangePasswordCubit>(
                            create: (context) => ChangePasswordCubit(),
                            child: const ChangePasswordPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/${AppRoutes.home}',
        name: AppRoutes.home,
        pageBuilder: TransitionFactory.slidingPageBuilder(
          child: BlocProvider<HubCubit>(
            create: (context) => HubCubit(),
            child: HubPage(),
          ),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profile,
            pageBuilder: TransitionFactory.slidingPageBuilder(
              child: BlocProvider<ProfileCubit>(
                create: (context) => ProfileCubit(),
                child: const ProfilePage(),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
