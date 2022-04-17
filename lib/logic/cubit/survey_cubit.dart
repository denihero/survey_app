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
    } catch (_) {
      emit(SurveyError());
    }
  }
}