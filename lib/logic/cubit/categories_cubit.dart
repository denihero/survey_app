import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/logic/bloc/login_api.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<Cat> {
  CategoriesCubit() : super(CategoriesInitial());

  get_category(String token) async {
    try {
      var v = await get_categories(token);
      emit(Categoriess(v));
    } catch (_) {
      emit(CategoriesError());
    }
  }
}
