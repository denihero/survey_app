part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final email;
  const AuthState({this.email = ""});

  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"email": email};
  }

  @override
  List<Object> get props => [email];
}

class AuthInitial extends AuthState {
  const AuthInitial({email = ""}) : super(email: email);

  @override
  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }
}

class AuthLoading extends AuthState {
  const AuthLoading(e) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthLoading(
      map["email"] as String,
    );
  }
}

class AuthSuccess extends AuthState {
  const AuthSuccess(e) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthSuccess(
      map["email"] as String,
    );
  }
}

class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess({e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthRegisterSuccess(
      e: map["email"] as String,
    );
  }
}


class AuthError extends AuthState {
  const AuthError({e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthError(
      e: map["email"] as String,
    );
  }
}
