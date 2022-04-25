import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'dart:convert';
import 'dart:convert';

import 'package:survey/logic/bloc/login_api.dart';

import '../../core/models/survey.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeInitial());
  delete_likes(Surveys survey, String token) {
    try {
      final map = Map<Surveys, int>.from(state.favorites);
      delete_like(map[survey]!, token);
      map.remove(survey);
      emit(LikeSuccess(map));
      // List<Surveys> ls = state.favorites.toList();
      // ls.removeWhere((element) => )
    } catch (_) {
      emit(LikeError());
    }
  }

  add_like(Surveys survey, String token) async {
    try {
      final map = Map<Surveys, int>.from(state.favorites);
      int like_index = await post_like(survey.id, token);
      map.addAll(
        {
          survey: like_index,
        },
      );
      emit(LikeSuccess(map));
    } catch (_) {
      emit(LikeError());
    }
  }

  get_like(String token) async {
    emit(LikeLoading());
    Map<Surveys, int> ls = {};
    try {
      var data = await get_likes(token);
      for (var m in data) {
        ls[await get_survey_via_id(m['survey'], token)] = m['id'];
      }
      if (data.isEmpty)
        emit(LikeEmpty());
      else {
        emit(LikeSuccess(ls));
      }
    } catch (_) {
      emit(LikeError());
    }
  }

  @override
  void onChange(Change<LikeState> change) {
    print(change);
    super.onChange(change);
  }
}
