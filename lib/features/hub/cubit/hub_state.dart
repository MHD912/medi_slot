part of 'hub_cubit.dart';

@immutable
sealed class HubState {}

final class HubInitial extends HubState {}

final class NavBarChange extends HubState {}

final class LogoutLoading extends HubState {}

final class LogoutSuccess extends HubState {}

final class LogoutError extends HubState {}
