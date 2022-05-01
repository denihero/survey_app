part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final String email;
  final String token;
  final String name;
  final String surname;
  final String? image;
  const AuthState( 
      {this.name = "", this.surname = "", this.email = "", this.token = "",this.image});

  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
        map["token"] as String,
        map["name"] as String,
        map["surname"] as String,
        map["image"] as String,
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"email": email, "token": token, "name": name, "surname": surname,"image":image??""};
  }

  @override
  List<Object> get props => [email];
}

class AuthInitial extends AuthState {
  const AuthInitial({String email = "", String token = ""})
      : super(email: email, token: token);

  @override
  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
        map["token"] as String,
        map["name"] as String,
        map["surname"] as String,
        map["image"] as String, 
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }
}

class AuthLoading extends AuthState {
  const AuthLoading(String e) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthLoading(
      map["email"] as String,
    );
  }
}

class AuthSuccess extends AuthState {
  const AuthSuccess(String e, String token, String name, String surname,String? image)
      : super(email: e, token: token, name: name, surname: surname,image: image);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthSuccess(
      map["email"] as String,
      map["token"] as String,
      map["name"] as String,
      map["surname"] as String,
      map["image"] as String,
    );
  }

  @override
  String toString() {
    return "$name $surname $email $image";
  }
}

class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess({String e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthRegisterSuccess(
      e: map["email"] as String,
    );
  }
}

class AuthError extends AuthState {
  const AuthError({String e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthError(
      e: map["email"] as String,
    );
  }
}

class AuthConfirmPasswordSucces extends AuthState {
  const AuthConfirmPasswordSucces({String e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthError(
      e: map["email"] as String,
    );
  }
}
