import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';

class RegisterInitialWidget extends StatefulWidget {
  const RegisterInitialWidget({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.passwordRepeatController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordRepeatController;

  @override
  State<RegisterInitialWidget> createState() => _RegisterInitialWidgetState();
}

class _RegisterInitialWidgetState extends State<RegisterInitialWidget> {
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

  late bool isShowed = true;
  late bool confirmIsShowed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: BackButton(
            color: BLACK,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text("Some error Occured"),
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
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create Account',
                      style: Monsterats_600_28_FONT_SIZE_BLACK,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.emailAddress,
                          textAlignVertical: TextAlignVertical.bottom,
                          cursorHeight: 18,
                          style: const TextStyle(fontSize: 18),
                          controller: widget.usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.email, size: 23),
                            ),
                            hintText: "Username or email",
                            hintStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: isShowed,
                          cursorHeight: 18,
                          style: const TextStyle(fontSize: 18),
                          controller: widget.passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: const TextStyle(fontSize: 18),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.lock, size: 23),
                            ),
                            suffixIcon: IconButton(
                              icon: isShowed
                                  ? const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Icon(Icons.visibility_off),
                              )
                                  : const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Icon(Icons.visibility),
                              ),
                              onPressed: () {
                                setState(() {
                                  isShowed = !isShowed;
                                });
                              },
                            ),
                            hintText: "Password",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                        child: TextFormField(
                          controller: widget.passwordRepeatController,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: confirmIsShowed,
                          cursorHeight: 18,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: const TextStyle(fontSize: 18),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.lock, size: 23),
                            ),
                            suffixIcon: IconButton(
                              icon: confirmIsShowed
                                  ? const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Icon(Icons.visibility_off),
                              )
                                  : const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Icon(Icons.visibility),
                              ),
                              onPressed: () {
                                setState(() {
                                  confirmIsShowed = !confirmIsShowed;
                                });
                              },
                            ),
                            hintText: "Confirm Password",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18)))),
                              backgroundColor:
                              MaterialStateProperty.all(ORANGE),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Sign up",
                                  style: Monsterats_400_16_FONT_SIZE_BLACK,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                )
                              ],
                            ),
                            onPressed: () {
                              final email = widget.usernameController.text;
                              final password = widget.passwordController.text;
                              final repeat =
                                  widget.passwordRepeatController.text;
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
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 60),
        child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Already have a account ? ',
                style: Monsterats_500_16_FONT_SIZE_BLACK.copyWith(
                    color: Colors.grey.shade500, fontSize: 15),
              ),
              TextSpan(
                  text: 'Sign in',
                  style: Monsterats_800_15_FONT_SIZE_ORANGE.copyWith(color: ORANGE),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed("/login");
                    })
            ])),
      ),
    );
  }
}