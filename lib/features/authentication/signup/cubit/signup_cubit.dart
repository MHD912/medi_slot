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
