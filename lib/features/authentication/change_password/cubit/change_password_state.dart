part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordError extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordTogglePassword extends ChangePasswordState {}

final class ChangePasswordToggleConfirmPassword extends ChangePasswordState {}
