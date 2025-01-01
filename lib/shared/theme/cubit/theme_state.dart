part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.themeMode});
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged({required super.themeMode});
}
