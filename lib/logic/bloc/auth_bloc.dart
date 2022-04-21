import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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

class AuthConfirmPassword extends AuthEvent {
  final code;
  AuthConfirmPassword(String username, String password, this.code)
      : super(username, password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> with HydratedMixin {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      if (state.email != "") {
        emit(
          AuthSuccess(state.email),
        );
      }
      emit(const AuthLoading(""));
      try {
        var r = await login(event.username, event.password);
        if (r) {
          var email = event.username;
          emit(AuthSuccess(email));
        } else if (r == false) {
          emit(const AuthError());
        }
      } catch (_) {
        emit(const AuthError());
      }
    });
    on<AuthRegister>((event, emit) async {
      try {
        emit(AuthLoading(""));
        var r = await register(event.username, event.password);
        if (r) {
          emit(AuthRegisterSuccess());
        } else if (r == false) {
          emit(AuthError());
        }
      } catch (_) {
        emit(AuthError());
      }
    });
    on<AuthConfirmPassword>((event, emit) async {
      try {
        emit(AuthLoading(""));
        var r = await confirmPassword(event.username, event.code);
        if (r) {
          emit(AuthInitial());
        } else if (r == false) {
          emit(AuthError());
        }
      } catch (_) {}
    });
    on<AuthLogout>((event, emit) {
      emit(AuthLoading(""));
      emit(
        AuthInitial(),
      );
    });
  }

  @override
  void onChange(Change<AuthState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    print(transition);
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return state.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
