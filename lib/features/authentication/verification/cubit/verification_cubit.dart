import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  final globalKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  String? Function(String?)? validator;

  void clearValidator() {
    validator = (String? value) {
      return null;
    };
    emit(ValidatorCleared());
  }
}
