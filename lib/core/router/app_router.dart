import 'package:flutter/material.dart';
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
import 'package:medi_slot/features/home/cubit/home_cubit.dart';

import '../../features/home/page/home_page.dart';
import '../../features/onboarding/onboarding_page/cubit/onboarding_cubit.dart';
import '../../features/onboarding/onboarding_page/page/onboarding_page.dart';
import '../../features/onboarding/welcome_page/page/welcome_page.dart';
import '../../features/splash/page/splash_screen.dart';
import '../constants/app_routes.dart';
import '../utilities/transition_factory.dart';

class AppRouter {
  static final goRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoutes.splashScreen.name,
        builder: (context, state) => const SplashScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'onboarding',
            name: AppRoutes.onboarding.name,
            pageBuilder: TransitionFactory.fadingPageBuilder(
              child: BlocProvider<OnboardingCubit>(
                create: (context) => OnboardingCubit(),
                child: OnboardingPage(),
              ),
            ),
          ),
          GoRoute(
            path: 'welcome',
            name: AppRoutes.welcome.name,
            pageBuilder: TransitionFactory.slidingPageBuilder(
              child: const WelcomePage(),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: 'signup',
                name: AppRoutes.signup.name,
                pageBuilder: TransitionFactory.slidingPageBuilder(
                  child: BlocProvider<SignupCubit>(
                    create: (context) => SignupCubit(),
                    child: const SignupPage(),
                  ),
                ),
              ),
              GoRoute(
                path: 'login',
                name: AppRoutes.login.name,
                pageBuilder: TransitionFactory.slidingPageBuilder(
                  child: BlocProvider<LoginCubit>(
                    create: (context) => LoginCubit(),
                    child: const LoginPage(),
                  ),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'forgot_password',
                    name: AppRoutes.forgotPassword.name,
                    pageBuilder: TransitionFactory.slidingPageBuilder(
                      child: BlocProvider<ForgotPasswordCubit>(
                        create: (context) => ForgotPasswordCubit(),
                        child: const ForgotPasswordPage(),
                      ),
                    ),
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'verification',
                        name: AppRoutes.verification.name,
                        pageBuilder: TransitionFactory.slidingPageBuilder(
                          child: BlocProvider<VerificationCubit>(
                            create: (context) => VerificationCubit(),
                            child: const VerificationPage(),
                          ),
                        ),
                        routes: <RouteBase>[
                          GoRoute(
                            path: 'change_password',
                            name: AppRoutes.changePassword.name,
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
            path: 'home',
            name: AppRoutes.home.name,
            pageBuilder: TransitionFactory.slidingPageBuilder(
              child: BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(),
                child: const HomePage(),
              ),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: 'profile',
                name: AppRoutes.profile.name,
                pageBuilder: TransitionFactory.slidingPageBuilder(
                  child: const Placeholder(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
