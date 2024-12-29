part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingSkip extends OnboardingState {}

final class OnboardingNext extends OnboardingState {}

final class OnboardingGetStarted extends OnboardingState {}
