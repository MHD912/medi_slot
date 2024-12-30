part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordError extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {}
