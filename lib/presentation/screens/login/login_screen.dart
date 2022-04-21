import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/main_page.dart';
import 'package:survey/presentation/screens/registration/sign_up_screen.dart';
import '../../../logic/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          print(state);
          if (state is AuthInitial ||
              state is AuthError ||
              state is AuthRegisterSuccess) {
            return LoginInitialWidget(
              usernameController: usernameController,
              passwordController: passwordController,
            );
          } else if (state is AuthSuccess || state.email != "") {
            BlocProvider.of<CategoriesCubit>(context).get_category();
            BlocProvider.of<SurveyCubit>(context).fetch_surveys_stream();
            return const MainPage();
          }
          return const Center(child: CircularProgressIndicator());
        },
        // buildWhen: (context, state) {
        //   if (state is AuthSuccess) return true;
        //   return state is AuthError ? false : true;
        // },
        listener: (context, state) {
          state is AuthError
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid email or password or Error"),
                  ),
                )
              : null;
        },
      ),
    );
  }
}

class LoginInitialWidget extends StatefulWidget {
  const LoginInitialWidget({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<LoginInitialWidget> createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget> {
  bool check(String name, String password) {
    if (name.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  late bool isShowed = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Login\n', style: Monsterats_600_28_FONT_SIZE_BLACK),
                TextSpan(
                    text: 'Please sign in to continue.',
                    style: Monsterats_600_18_FONT_SIZE_GREY)
              ]),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: TextFormField(
                  textCapitalization: TextCapitalization.none,
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
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: TextFormField(
                  controller: widget.passwordController,
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: isShowed,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)))),
                        backgroundColor: MaterialStateProperty.all(ORANGE),
                      ),
                      onPressed: () {
                        check(widget.usernameController.text,
                                widget.passwordController.text)
                            ? BlocProvider.of<AuthBloc>(context).add(
                                AuthLogin(widget.usernameController.text,
                                    widget.passwordController.text),
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Entered invalid data!"),
                                ),
                              );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Login ",
                            style: Monsterats_400_16_FONT_SIZE_BLACK,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.27,
          // ),
          Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Don\'t have account ? ',
                  style: Monsterats_500_16_FONT_SIZE_BLACK.copyWith(
                      color: Colors.grey.shade500),
                ),
                TextSpan(
                    text: 'Sign up',
                    style: Monsterats_800_15_FONT_SIZE_ORANGE.copyWith(
                        color: ORANGE),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterInitialWidget(
                                    usernameController: TextEditingController(),
                                    passwordController: TextEditingController(),
                                    passwordRepeatController:
                                        TextEditingController(),
                                  )),
                        );
                      })
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
