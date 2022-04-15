import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'login_api.dart';

part 'auth_state.dart';

abstract class AuthEvent extends Equatable {
  final String username;
  final String password;

  AuthEvent(this.username, this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}

class AuthLogin extends AuthEvent {
  AuthLogin(String username, String password) : super(username, password);
}

class AuthLogout extends AuthEvent {
  AuthLogout() : super("", "");
}

class AuthRegister extends AuthEvent {
  AuthRegister(String username, String password) : super(username, password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var email = "";
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      var r = await login(event.username, event.password);
      if (r) {
        email = event.username;
        emit(AuthSuccess(email));
      } else if (r == false) {
        emit(AuthError());
      }
    });
    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());
      var r = await register(event.username, event.password);
      if (r) {
        emit(AuthRegisterSuccess());
      } else if (r == false) {
        emit(AuthError());
      }
    });
    on<AuthLogout>(
      (event, emit) => emit(
        AuthInitial(),
      ),
    );
  }

  @override
  void onChange(Change<AuthState> change) {
    print(change);
    super.onChange(change);
  }
}
