part of 'localization_cubit.dart';

@immutable
sealed class LocalizationState {
  final Locale locale;
  const LocalizationState({required this.locale});
}

final class LocalizationInitial extends LocalizationState {
  const LocalizationInitial({required super.locale});
}

final class LocaleChanged extends LocalizationState {
  const LocaleChanged({required super.locale});
}
