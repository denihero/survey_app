part of 'categories_cubit.dart';

abstract class Cat extends Equatable {
  final List<String> categories=[];
}

class Categoriess extends Cat {
  final List<String> categories;
  Categoriess(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoriesInitial extends Cat {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CategoriesError extends Cat {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
