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
      List<Surveys> r = await get_surveys();
      print(r.length);
      emit(SurveyCompleted(surveys: r));
    } on Empty {
      emit(SurveyEmpty());
    } catch (_) {
      emit(SurveyError());
    }
  }

  fetch_surveys_stream() async {
    try {
      await get_surveys_stream_fixed().fold(
        Surveys(title: "Hello"),
        ((previous, element) {
          final new_state = SurveyCompleted(surveys: [
            ...state.surveys,
            ...[element]
          ]);
          emit(new_state);
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
