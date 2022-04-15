import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/bloc/login_api.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/presentation/main_page.dart';
import 'package:survey/presentation/screens/home/home_screen.dart';
import '../../../logic/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial ||
              state is AuthError ||
              state is AuthRegisterSuccess) {
            return LoginInitialWidget(
              usernameController: usernameController,
              passwordController: passwordController,
            );
          } else if (state is AuthSuccess) {
            BlocProvider.of<CategoriesCubit>(context).get_category();
            return const MainPage();
          }
          return const CircularProgressIndicator();
        },
        buildWhen: (context, state) {
          if (state is AuthSuccess) return true;
          return state is AuthError || state is AuthLoading ? false : true;
        },
        listener: (context, state) {
          state is AuthError
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid email or password"),
                  ),
                )
              : null;
        },
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

  bool check(String name, String password) {
    if (name.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
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
                onPressed: () {
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterInitialWidget(
                              usernameController: TextEditingController(),
                              passwordController: TextEditingController(),
                              passwordRepeatController: TextEditingController(),
                            )),
                  );
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterInitialWidget extends StatelessWidget {
  const RegisterInitialWidget({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.passwordRepeatController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordRepeatController;

  bool check(String name, String password, String repeat) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(name);
    if (name.isEmpty ||
        password.length < 6 ||
        password != repeat ||
        !emailValid) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisterSuccess) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          const Text("Check your email for confirmation code"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/login");
                          },
                          child: const Center(child: Text("OK")),
                        ),
                      ],
                    );
                  });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
              ),
              TextFormField(
                controller: passwordRepeatController,
                decoration: const InputDecoration(
                  hintText: "Confirm password",
                ),
              ),
              Center(
                child: TextButton(
                  child: const Text("Register"),
                  onPressed: () {
                    final email = usernameController.text;
                    final password = passwordController.text;
                    final repeat = passwordRepeatController.text;
                    check(email, password, repeat)
                        ? BlocProvider.of<AuthBloc>(context).add(
                            AuthRegister(email, password),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Entered invalid data!"),
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
