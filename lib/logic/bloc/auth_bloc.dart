import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'login_api.dart';

part 'auth_state.dart';

abstract class AuthEvent {
  final String username;
  final String password;

  AuthEvent(this.username, this.password);
}

class AuthLogin extends AuthEvent {
  AuthLogin(String username, String password) : super(username, password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      var r = await login(event.username, event.password);
      if (r) {
        emit(AuthSuccess());
      } else if (r == false) {
        emit(AuthError());
      }
    });
  }

  @override
  void onChange(Change<AuthState> change) {
    print(change);
    super.onChange(change);
  }
}
