part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {
  PostLoading():super();
}

class PostFinished extends PostState {
  PostFinished() : super();
}

class PostError extends PostState {}
