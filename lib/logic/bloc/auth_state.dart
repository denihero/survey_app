part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final email;
  final token;
  final name;
  final surname;
  const AuthState(
      {this.name = "", this.surname = "", this.email = "", this.token = ""});

  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
        map["token"] as String,
        map["name"] as String,
        map["surname"] as String,
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"email": email, "token": token,"name":name,"surname":surname};
  }

  @override
  List<Object> get props => [email];
}

class AuthInitial extends AuthState {
  const AuthInitial({email = "", token = ""})
      : super(email: email, token: token);

  @override
  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
        map["token"] as String,
        map["name"] as String,
        map["surname"] as String,
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
  const AuthSuccess(e, token, name, surname) : super(email: e, token: token,name: name,surname: surname);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthSuccess(
      map["email"] as String,
      map["token"] as String,
      map["name"] as String,
      map["surname"] as String,
    );
  }

  @override
  String toString() {
    return "$name $surname $email";
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

class AuthConfirmPasswordSucces extends AuthState {
  const AuthConfirmPasswordSucces({e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthError(
      e: map["email"] as String,
    );
  }
}
