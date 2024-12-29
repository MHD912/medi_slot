import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              child: BlocProvider(
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
                  child: const Placeholder(),
                ),
              ),
              GoRoute(
                path: 'login',
                name: AppRoutes.login.name,
                pageBuilder: TransitionFactory.slidingPageBuilder(
                  child: const Placeholder(),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'forgot_password',
                    name: AppRoutes.forgotPassword.name,
                    pageBuilder: TransitionFactory.slidingPageBuilder(
                      child: const Placeholder(),
                    ),
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'verification',
                        name: AppRoutes.verification.name,
                        pageBuilder: TransitionFactory.slidingPageBuilder(
                          child: const Placeholder(),
                        ),
                        routes: <RouteBase>[
                          GoRoute(
                            path: 'change_password',
                            name: AppRoutes.changePassword.name,
                            pageBuilder: TransitionFactory.slidingPageBuilder(
                              child: const Placeholder(),
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
              child: const HomePage(),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: 'home',
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
