import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/presentation/screens/home/home_screen.dart';
import '../../../logic/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial || state is AuthError) {
              return LoginInitialWidget(
                  usernameController: usernameController,
                  passwordController: passwordController);
            } else if (state is AuthSuccess) {
              return const HomeScreen();
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Text("");
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
    bool check(String name, String password) {
      if (name.isEmpty || password.length < 6) {
        return false;
      }
      return true;
    }

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
                check(usernameController.text, passwordController.text)
                    ? BlocProvider.of<AuthBloc>(context).add(
                        AuthLogin(
                            usernameController.text, passwordController.text),
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Entered invalid data!"),
                        ),
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
