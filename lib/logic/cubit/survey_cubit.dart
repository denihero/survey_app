import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/core/models/survey.dart';

import '../bloc/login_api.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyInitial());

  fetch_surveys() async {
    emit(SurveyLoading());
    try {
      List<Surveys> r = await get_surveys("");
      print(r.length);
      emit(SurveyCompleted(surveys: r));
    } on Empty {
      emit(SurveyEmpty());
    } catch (_) {
      emit(SurveyError());
    }
  }

  delete_survey(Surveys survey) {
    List<Surveys> copy_survey = state.surveys.toList();
    copy_survey.remove(survey);
    emit(
      SurveyCompleted(
        surveys: copy_survey,
      ),
    );
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
    print(state.surveys);
    try {
      await get_surveys_stream_fixed(token).fold(
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
