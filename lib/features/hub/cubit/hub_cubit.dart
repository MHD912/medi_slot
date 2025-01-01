import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_slot/core/constants/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utilities/global_variables.dart';

part 'hub_state.dart';

class HubCubit extends Cubit<HubState> {
  HubCubit() : super(HubInitial());

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int newValue) {
    _pageIndex = newValue;
    emit(NavBarChange());
  }

  Future<bool> logoutApiCall() async {
    final preferences = getIt.get<SharedPreferences>();
    final token = preferences.getString(AppPreferences.token);
    Response response;
    try {
      emit(LogoutLoading());
      response = await dio.post(
        'logout',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        emit(LogoutSuccess());
        preferences.remove(AppPreferences.token);
        return true;
      } else {
        throw Exception('unhandled status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('$runtimeType Error: $e');
      emit(LogoutError());
      return false;
    }
  }
}
