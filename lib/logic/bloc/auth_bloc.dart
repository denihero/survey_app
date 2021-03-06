import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

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

class AuthChangeInfo extends AuthEvent {
  File? file;
  AuthChangeInfo(this.file) : super("", "");
}

class AuthRegisterSendNameSurname extends AuthEvent {
  final File? file;
  final name;
  final surname;
  AuthRegisterSendNameSurname(
      {required String username,
      required String password,
      required this.name,
      required this.surname,
      this.file})
      : super(username, password);
}

class AuthConfirmPassword extends AuthEvent {
  final code;
  AuthConfirmPassword(String username, String password, this.code)
      : super(username, password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> with HydratedMixin {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      // if (state.email != "") {
      //   emit(
      //     AuthSuccess(state.email),
      //   );
      // }
      emit(const AuthLoading(""));
      try {
        String r = await login(event.username, event.password);
        log("Debug:");
        log(r);
        if (r.isNotEmpty) {
          String email = event.username;
          List<dynamic> nameSurname = await getNameSurname(event.username);
          print("NAme and surname:");
          print(nameSurname);
          emit(
            AuthSuccess(email, r, nameSurname[0], nameSurname[1],
                nameSurname[2], nameSurname[3]),
          );
        } else if (r.isEmpty) {
          emit(const AuthError());
        }
      } catch (e) {
        print(e);
        emit(const AuthError());
      }
    });

    on<AuthRegister>((event, emit) async {
      try {
        emit(const AuthLoading(""));
        var r = await register(event.username, event.password);
        if (r) {
          emit(const AuthRegisterSuccess());
        } else if (r == false) {
          emit(const AuthError());
        }
      } catch (_) {
        emit(const AuthError());
      }
    });
    on<AuthConfirmPassword>((event, emit) async {
      try {
        emit(const AuthLoading(""));
        var r = await confirmPassword(event.username, event.code);
        if (r) {
          emit(const AuthConfirmPasswordSucces());
        } else if (r == false) {
          emit(const AuthError());
        }
      } catch (_) {
        emit(const AuthError());
      }
    });
    on<AuthRegisterSendNameSurname>((event, emit) async {
      try {
        emit(const AuthLoading(""));

        var token = await login(event.username, event.password);
        print("Send name Username:");
        var r =
            await sendNameSurname(event.name, event.surname, token, event.file);
        emit(const AuthInitial());
      } catch (r) {
        print(r);
        emit(const AuthError());
      }
    });
    on<AuthLogout>((event, emit) {
      emit(const AuthLoading(""));
      emit(
        const AuthInitial(),
      );
    });
    on<AuthChangeInfo>(
      (event, emit) async {
        String email = state.email;
        String token = state.token;
        String name = state.name;
        String surname = state.surname;
        int id = state.id_info;
        emit(const AuthLoading(""));
        try {
          String imageLink =
              await putImage(event.file, id, token, name, surname);
          emit(AuthSuccess(email, token, name, surname, imageLink, id));
        } catch (e) {
          emit(const AuthError());
        }
      },
    );
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
