import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/core/models/submission.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/login_api.dart';

class SurveyCurrentCubit extends Cubit<Surveys?> {
  Map<Questions, int> answers = {};
  SurveyCurrentCubit() : super(null);
  void set_current(Surveys s) {
    emit(s);
  }

  post_submissions(String email, int survey,String token) async {
    List<int> final_answers = <int>[];
    print(answers);
    answers.forEach((key, value) {
      final_answers.add(value);
    });
    final sub = Submission(
        participation_email: email, survey: survey, answer: final_answers);
    try{
    await post_sumbissions(sub,token);
    }
    catch(_){}
    answers = <Questions, int>{};
    emit(null);
  }
}
