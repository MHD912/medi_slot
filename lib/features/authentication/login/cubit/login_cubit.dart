import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_slot/core/constants/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utilities/global_variables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginTogglePassword());
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
