import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
final dio = Dio(
  BaseOptions(
    baseUrl: 'http://testflutter.aboodm.com/api/',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    validateStatus: (status) {
      if (status != null && status >= 200 && status <= 422) {
        return true;
      } else {
        return false;
      }
    },
  ),
);
