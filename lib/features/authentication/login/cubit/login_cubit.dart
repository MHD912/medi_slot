import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_preferences.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utilities/global_variables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginTogglePassword());
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr(AppStrings.errorEmpty);
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return tr(AppStrings.emailInvalid);
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr(AppStrings.errorEmpty);
    }
    return null;
  }

  bool validateInput() {
    var emailResult = emailFormKey.currentState?.validate() ?? false;
    var passwordResult = passwordFormKey.currentState?.validate() ?? false;
    return (emailResult && passwordResult);
  }

  void clearEmailValidation() {
    emailFormKey.currentState?.reset();
  }

  void clearPasswordValidation() {
    passwordFormKey.currentState?.reset();
  }

  Future<bool> loginApiCall() async {
    var data = jsonEncode({
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    });
    Response response;
    try {
      emit(LoginLoading());
      response = await dio.post(
        'login',
        data: data,
      );
      if (response.statusCode == 200) {
        emit(LoginSuccess());
        final token = response.data['access_token'] as String;
        await getIt.get<SharedPreferences>().setString(
              AppPreferences.token,
              token,
            );
        return true;
      } else {
        throw Exception('unhandled status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('$runtimeType Error: $e');
      emit(LoginError());
      return false;
    }
  }
}
