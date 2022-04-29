part of './survey_cubit.dart';

@immutable
abstract class SurveyState extends Equatable {
  final bool hasReachedMax;
  String? category_chosen;
  final List<Surveys> surveys;
  SurveyState({this.hasReachedMax = false, this.surveys = const <Surveys>[]});
  @override
  List<Object> get props => [surveys];
}

class SurveyInitial extends SurveyState {
  String? category_chosen;
  SurveyInitial({surveys = const <Surveys>[]}) : super(surveys: surveys);
}

class SurveyCompleted extends SurveyState {
  String? category_chosen;
  SurveyCompleted(
      {surveys = const <Surveys>[], this.category_chosen, bool hasMax = false})
      : super(surveys: surveys, hasReachedMax: hasMax);
  @override
  List<Object> get props => [surveys, category_chosen ?? "", hasReachedMax];
}

class SurveyError extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveyEmpty extends SurveyState {}

abstract class SurveyMine extends Equatable {
  final bool hasReachedMax;
  final List<Surveys> surveys;
  SurveyMine({this.hasReachedMax=false,this.surveys = const <Surveys>[]});
  @override
  // TODO: implement props
  List<Object?> get props => [surveys,hasReachedMax];
}

class SurveyMineInitial extends SurveyMine {
  SurveyMineInitial() : super();
}

class SurveyMineLoading extends SurveyMine {
  SurveyMineLoading() : super();
}

class SurveyMineEmpty extends SurveyMine {
  SurveyMineEmpty() : super();
}

class SurveyMineError extends SurveyMine {
  SurveyMineError() : super();
}

class SurveyMineCompleted extends SurveyMine {
  SurveyMineCompleted(List<Surveys> surveys,{has=false}) : super(surveys: surveys,hasReachedMax: has);
}
