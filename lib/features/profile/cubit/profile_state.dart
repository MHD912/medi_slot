part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GenderChanged extends ProfileState {}

final class DateChanged extends ProfileState {}
