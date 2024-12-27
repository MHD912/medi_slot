part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashEnd extends SplashState {
  final String routeName;
  SplashEnd({required this.routeName});
}
