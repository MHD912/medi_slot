part of 'recent_visit_cubit.dart';

@immutable
sealed class RecentVisitState {
  final bool isFavorite;
  const RecentVisitState({required this.isFavorite});
}

final class RecentVisitInitial extends RecentVisitState {
  const RecentVisitInitial({required super.isFavorite});
}

final class FavoriteChanged extends RecentVisitState {
  const FavoriteChanged({required super.isFavorite});
}
