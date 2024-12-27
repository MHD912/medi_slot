import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionFactory {
  static CustomTransitionPage _slideTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(
              CurveTween(
                curve: Curves.easeInOut,
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }

  static Page<dynamic> Function(BuildContext context, GoRouterState state)
      slidingPageBuilder({required Widget child}) => (context, state) {
            return _slideTransitionPage(
              state: state,
              child: child,
            );
          };

  static CustomTransitionPage _fadeTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(
            curve: Curves.easeInOutCirc,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Page<dynamic> Function(BuildContext context, GoRouterState state)
      fadingPageBuilder({required Widget child}) {
    return (context, state) => _fadeTransitionPage(
          state: state,
          child: child,
        );
  }
}
