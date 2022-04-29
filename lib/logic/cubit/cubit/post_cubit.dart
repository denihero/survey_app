import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/login_api.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  postSurvey(Surveys survey, String token, File? file,String email) async {
    emit(PostLoading());
    try {
      var result = await post_survey(survey, token, file);
      Surveys last = await getLastSurvey(email, token);
      emit(PostFinished(last));
    } catch (_) {
      emit(PostError());
    } finally {}
  }

  changeToInitial() {
    emit(PostInitial());
  }

  @override
  void onChange(Change<PostState> change) {
    print(change);
    super.onChange(change);
  }
}
