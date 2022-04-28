import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:survey/core/models/survey.dart';

import '../bloc/login_api.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyInitial());
  bool is_category_filter = false;
  delete_survey(Surveys survey) {
    List<Surveys> copy_survey = state.surveys.toList();
    copy_survey.remove(survey);
    emit(
      SurveyCompleted(
        surveys: copy_survey,
      ),
    );
  }

  change_chosen(String cat) {
    emit(SurveyCompleted(surveys: state.surveys,category_chosen: cat));
  }
  // add_survey(Surveys survey) {
  //   List<Surveys> copy_survey = state.surveys.toList();
  //   copy_survey.add(survey);
  //   emit(
  //     SurveyCompleted(
  //       surveys: copy_survey,
  //     ),
  //   );
  // }

  fetch_surveys_stream(String token) async {
    emit(SurveyLoading());
    try {
      await get_surveys_stream_fixed(token).fold(
        Surveys(id: -1, title: "Hello"),
        ((previous, element) {
          if (!state.surveys.contains(element) && !is_category_filter) {
            final new_state = SurveyCompleted(surveys: [
              ...state.surveys,
              ...[element]
            ]);
            emit(new_state);
          }
          return;
        }),
      );
    } on Empty {
      emit(SurveyEmpty());
    } on UnimplementedError {
      emit(SurveyError());
    }
  }

  fetch_surveys_stream_category(String category, String token) async {
    emit(SurveyLoading());
    try {
      await get_surveys_via_category_stream_fixed(token, category).fold(
        Surveys(id: -1, title: "Hello"),
        ((previous, element) {
          if (!state.surveys.contains(element)) {
            final new_state = SurveyCompleted(surveys: [
              ...state.surveys,
              ...[element]
            ]);
            emit(new_state);
          }
          return;
        }),
      );
    } on Empty {
      emit(SurveyEmpty());
    } on UnimplementedError {
      emit(SurveyError());
    }
  }
}
