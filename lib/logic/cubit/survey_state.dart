part of './survey_cubit.dart';

abstract class SurveyState extends Equatable {
  final List<Surveys> surveys;
  SurveyState({this.surveys = const <Surveys>[]});
  @override
  List<Object> get props => [surveys];
}

class SurveyInitial extends SurveyState {
  SurveyInitial({surveys = const <Surveys>[]}) : super(surveys: surveys);
}

class SurveyCompleted extends SurveyState {
  SurveyCompleted({surveys = const <Surveys>[]}) : super(surveys: surveys);
}

class SurveyError extends SurveyState {}

class SurveyLoading extends SurveyState {}
