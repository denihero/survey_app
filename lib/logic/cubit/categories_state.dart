part of 'categories_cubit.dart';

abstract class Cat extends Equatable {
  final Map<String, String> categories = {};
  @override
  // TODO: implement props
  List<Object?> get props => [ categories];
}

class Categoriess extends Cat {
  final Map<String, String> categories;
  Categoriess(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoriesInitial extends Cat {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoriesError extends Cat {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
