import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/core/models/survey.dart';

class SurveyCurrentCubit extends Cubit<Surveys?> {
  SurveyCurrentCubit() : super(null);
  void set_current(Surveys s) {
    emit(s);
  }
}
