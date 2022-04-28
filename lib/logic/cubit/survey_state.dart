part of './survey_cubit.dart';

@immutable
abstract class SurveyState extends Equatable {

  String? category_chosen;
  final List<Surveys> surveys;
  SurveyState({this.surveys = const <Surveys>[]});
  @override
  List<Object> get props => [surveys];
}

class SurveyInitial extends SurveyState {
  String? category_chosen;
  SurveyInitial({surveys = const <Surveys>[]}) : super(surveys: surveys);
}

class SurveyCompleted extends SurveyState {
  String? category_chosen;
  SurveyCompleted({surveys = const <Surveys>[],this.category_chosen}) : super(surveys: surveys);
  @override
  List<Object> get props => [surveys,category_chosen??""];
}

class SurveyError extends SurveyState {}

class SurveyLoading extends SurveyState {}
class SurveyEmpty extends SurveyState {}
