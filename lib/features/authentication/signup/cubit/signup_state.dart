part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupError extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupTogglePassword extends SignupState {}

final class SignupToggleConfirmPassword extends SignupState {}
