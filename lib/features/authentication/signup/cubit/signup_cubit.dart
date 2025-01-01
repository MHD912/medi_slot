import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utilities/global_variables.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (value != passwordController.text.trim()) {
      return 'Passwords do not match';
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
