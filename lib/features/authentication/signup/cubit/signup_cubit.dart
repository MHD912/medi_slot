import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utilities/global_variables.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignupTogglePassword());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SignupToggleConfirmPassword());
  }

  void clearNameValidation() {
    nameFormKey.currentState?.reset();
  }

  void clearEmailValidation() {
    emailFormKey.currentState?.reset();
  }

  void clearPasswordValidation() {
    passwordFormKey.currentState?.reset();
  }

  void clearConfirmPasswordValidation() {
    confirmPasswordFormKey.currentState?.reset();
  }

  bool validateInput() {
    var nameResult = nameFormKey.currentState?.validate() ?? false;
    var emailResult = emailFormKey.currentState?.validate() ?? false;
    var passwordResult = passwordFormKey.currentState?.validate() ?? false;
    var confirmPasswordResult =
        confirmPasswordFormKey.currentState?.validate() ?? false;
    return (nameResult &&
        emailResult &&
        passwordResult &&
        confirmPasswordResult);
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(AppStrings.errorEmpty);
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(AppStrings.errorEmpty);
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return tr(AppStrings.emailInvalid);
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(AppStrings.errorEmpty);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(AppStrings.errorEmpty);
    }
    if (value != passwordController.text.trim()) {
      return tr(AppStrings.errorPasswordNotMatch);
    }
    return null;
  }

  Future<bool> signupApiCall() async {
    var data = jsonEncode({
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "password_confirmation": confirmPasswordController.text.trim(),
    });
    Response response;
    try {
      emit(SignupLoading());
      response = await dio.post(
        'register',
        data: data,
      );
      if (response.statusCode == 200) {
        emit(SignupSuccess());
        return true;
      } else {
        throw Exception('unhandled status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('$runtimeType Error: $e');
      emit(SignupError());
      return false;
    }
  }
}
