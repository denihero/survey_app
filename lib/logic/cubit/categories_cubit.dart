import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey/logic/bloc/login_api.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<Categoriess> {
  CategoriesCubit() : super(Categoriess([]));

  get_category() async {
    var v = await get_categories();
    emit(Categoriess(v));
  }
}
