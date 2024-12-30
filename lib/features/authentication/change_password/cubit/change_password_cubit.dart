import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordTogglePassword());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ChangePasswordToggleConfirmPassword());
  }
}
