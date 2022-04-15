part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final email;
  const AuthState({this.email = ""});

  @override
  List<Object> get props => [email];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  const AuthSuccess(e):super(email:e );
}

class AuthRegisterSuccess extends AuthState {}

class AuthError extends AuthState {}
