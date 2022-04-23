import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/logic/bloc/login_api.dart';

import '../../core/models/survey.dart';

class SurveyCurrentPost extends Cubit<SurveyPost> {
  SurveyCurrentPost() : super(SurveyPostInitial());
  updateSurveyInProgress(Surveys survey) {
    emit(SurveyPostInProgress(survey));
  }

  postSurvey(String token) async {
    emit(SurveyPostLoading());
    try {
      await post_survey(state.surveys, token);
      emit(
        SurveyPostInitial(),
      );
    } catch (_) {
      emit(SurveyPostError());
    }

  }
}

abstract class SurveyPost extends Equatable {
  final Surveys surveys;
  const SurveyPost(this.surveys);
  @override
  // TODO: implement props
  List<Object?> get props => [surveys];
}

class SurveyPostInitial extends SurveyPost {
  SurveyPostInitial() : super(Surveys(id: -1));
}

class SurveyPostInProgress extends SurveyPost {
  const SurveyPostInProgress(Surveys surveys) : super(surveys);
}

class SurveyPostLoading extends SurveyPost {
  SurveyPostLoading() : super(Surveys(id: -1));
}

class SurveyPostError extends SurveyPost {
  SurveyPostError() : super(Surveys(id: -1));
}
