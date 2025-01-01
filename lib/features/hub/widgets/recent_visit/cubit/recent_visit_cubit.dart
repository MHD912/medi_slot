import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recent_visit_state.dart';

class RecentVisitCubit extends Cubit<RecentVisitState> {
  RecentVisitCubit()
      : super(
          RecentVisitInitial(isFavorite: false),
        );
  bool isFavorite = false;

  void toggleFavorite() {
    isFavorite = !isFavorite;
    emit(
      FavoriteChanged(isFavorite: isFavorite),
    );
  }
}
