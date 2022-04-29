import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/login_api.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  postSurvey(Surveys survey, String token, File? file) async {
    emit(PostLoading());
    try {
      await post_survey(survey, token, file);
      emit(PostFinished());
    } catch (_) {
      emit(PostError());
    }
  }

  @override
  void onChange(Change<PostState> change) {
    print(change);
    super.onChange(change);
  }
}
