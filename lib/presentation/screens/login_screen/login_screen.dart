import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return LoginInitialWidget(
                  usernameController: usernameController,
                  passwordController: passwordController);
            } else if (state is AuthSuccess) {
              return const Text("Success");
            } else if (state is AuthError) {
              return const Text("Error");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class LoginInitialWidget extends StatelessWidget {
  const LoginInitialWidget({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: usernameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Username or email",
          ),
        ),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(
            hintText: "Password",
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthLogin(usernameController.text, passwordController.text),
                );
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Register"),
            ),
          ],
        ),
      ],
    );
  }
}
