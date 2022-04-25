import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/logic/bloc/login_api.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<Cat> {
  CategoriesCubit() : super(CategoriesInitial());

  get_category(String token) async {
    print("Get categories");
    try {
      var v = await get_categories(token);
      print("Categories");
      print(v);
      log("$v");
      emit(Categoriess(v));
    } catch (e) {
      print(e);
      emit(CategoriesError());
    }
  }
}
