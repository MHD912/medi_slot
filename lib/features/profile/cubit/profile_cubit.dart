import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool _isMale = true;
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;
  bool get isMale => _isMale;

  set setSelectedDate(DateTime? dateTime) {
    _selectedDate = dateTime;
    emit(DateChanged());
  }

  void toggleGender() {
    _isMale = !_isMale;
    emit(GenderChanged());
  }

  String parseDate() {
    if (_selectedDate == null) return "";
    return DateFormat('d MMMM yyyy').format(_selectedDate!);
  }
}
