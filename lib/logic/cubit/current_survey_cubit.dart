import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/core/models/submission.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/login_api.dart';

class SurveyCurrentCubit extends Cubit<Surveys?> {
  Map<Choice, int> answers = {};
  SurveyCurrentCubit() : super(null);
  void set_current(Surveys s) {
    emit(s);
  }

  post_submissions(String email, int survey) async {
    List<int> final_answers = <int>[];
    answers.forEach((key, value) {
      final_answers.add(value);
    });
    final sub = Submission(
        participation_email: email, survey: survey, answer: final_answers);
    await post_sumbissions(sub);
    answers = <Choice, int>{};
    emit(null);
  }
}
