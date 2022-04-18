import 'package:bloc/bloc.dart';
import 'package:survey/core/models/submission.dart';
import 'package:survey/core/models/survey.dart';

class SubmissionCubit extends Cubit<Submission?> {
  SubmissionCubit() : super(null);
  void init(participation_email, survey) {
    emit(
      Submission(
          participation_email: participation_email, survey: survey, answer: []),
    );
  }
}
