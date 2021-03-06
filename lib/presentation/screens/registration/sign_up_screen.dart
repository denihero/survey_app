import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

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

  @override
  void dispose() {
    _codeController?.dispose();
    widget.passwordController.dispose();
    widget.usernameController.dispose();
    super.dispose();
  }

  bool _isShowCodeConfirm = false;
  bool _isShowNameSurname = false;
  TextEditingController? _codeController;
  TextEditingController? _nameController;
  TextEditingController? _surnameController;

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  pickImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      setState(() {
        this.imageFile = File(image.path);
      });
    } catch (_) {}
  }

  late bool isShowed = true;
  late bool confirmIsShowed = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: WillPopScope(  onWillPop:()async=>false,  child:Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: BackButton(
              color: BLACK,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(1.9.h),
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
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: const Center(child: Text("OK")),
                          ),
                        ],
                      );
                    });
              } else if (state is AuthInitial) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login", (route) => false);
              } else if (state is AuthConfirmPasswordSucces) {
                setState(() {
                  _isShowNameSurname = true;
                  // _isShowCodeConfirm = false;
                });
                _nameController = TextEditingController();
                _surnameController = TextEditingController();

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text("Please enter Your name and surname"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed("/login");
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: const Center(child: Text("OK")),
                          ),
                        ],
                      );
                    });
              } else if (state is AuthRegisterSuccess) {
                setState(() {
                  _isShowCodeConfirm = true;
                });
                _codeController = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content:
                            const Text("Check your email for confirmation code"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed("/login");
                              Navigator.of(context, rootNavigator: true).pop();
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
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 17.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _isShowCodeConfirm && _isShowNameSurname == false
                            ? 'Enter Code'
                            : _isShowNameSurname
                                ? "Enter name and surname"
                                : "Create account",
                        style: Monsterats_600_28_FONT_SIZE_BLACK,
                      ),
                    ),
                    SizedBox(
                      height: _isShowNameSurname ? 2.h : 7.h,
                    ),
                    !_isShowCodeConfirm
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  autocorrect: false,
                                  cursorHeight: 18,
                                  style: TextStyle(fontSize: 14.sp),
                                  controller: widget.usernameController,
                                  decoration: InputDecoration(
                                    iconColor: Colors.grey,
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(Icons.email, size: 3.h,color: Colors.grey,),
                                    ),
                                    hintText: "email",
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                  style: TextStyle(fontSize: 14.sp),
                                  controller: widget.passwordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(Icons.lock, size: 3.h,color: Colors.grey,),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: isShowed
                                          ? const Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Icon(Icons.visibility_off,color: Colors.grey,),
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Icon(Icons.visibility,color: Colors.grey,),
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
                              const SizedBox(
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
                                  style: TextStyle(fontSize: 14.sp),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(Icons.lock, size: 3.h,color: Colors.grey,),
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
                                          style:
                                              Monsterats_400_16_FONT_SIZE_BLACK,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      final email =
                                          widget.usernameController.text;
                                      final password =
                                          widget.passwordController.text;
                                      final repeat =
                                          widget.passwordRepeatController.text;
                                      check(email, password, repeat)
                                          ? BlocProvider.of<AuthBloc>(context)
                                              .add(
                                              AuthRegister(email, password),
                                            )
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text("Entered invalid data!"),
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        : const Text(""),
                    _isShowCodeConfirm && !_isShowNameSurname
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  cursorHeight: 18,
                                  style: TextStyle(fontSize: 14.sp),
                                  controller: _codeController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(Icons.code, size: 3.h),
                                    ),
                                    hintText: "Confirmation Code",
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
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
                                          "Send Code",
                                          style:
                                              Monsterats_400_16_FONT_SIZE_BLACK,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      final code = _codeController?.text;

                                      final email =
                                          widget.usernameController.text;
                                      BlocProvider.of<AuthBloc>(context).add(
                                          AuthConfirmPassword(email, "", code));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const Text(""),
                    _isShowNameSurname
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: pickImage,
                                child: CircleAvatar(
                                  backgroundColor: ORANGE,
                                  child: imageFile != null
                                      ? ClipOval(
                                          child: Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 100,
                                          ),
                                        )
                                      : const Text(
                                          "Upload",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                  radius: 50,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.none,
                                    keyboardType: TextInputType.text,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    cursorHeight: 18,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
                              ),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.none,
                                    keyboardType: TextInputType.text,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    cursorHeight: 18,
                                    style: TextStyle(fontSize: 14.sp),
                                    controller: _surnameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Surname",
                                      hintStyle: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
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
                                          "Confirm",
                                          style:
                                              Monsterats_400_16_FONT_SIZE_BLACK,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      print("Hello");
                                      final code = _codeController?.text;
                                      final email =
                                          widget.usernameController.text;
                                      print(email);
                                      print(widget.passwordController.text);
                                      BlocProvider.of<AuthBloc>(context).add(
                                        AuthRegisterSendNameSurname(
                                          name: _nameController?.text ?? "",
                                          file: imageFile,
                                          surname: _surnameController?.text,
                                          username: email,
                                          password:
                                              widget.passwordController.text,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const Text(""),
                    const Spacer(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Already have a account ? ',
                        style: Monsterats_500_16_FONT_SIZE_BLACK.copyWith(
                            color: Colors.grey.shade500, fontSize: 15),
                      ),
                      TextSpan(
                          text: 'Sign in',
                          style: Monsterats_800_15_FONT_SIZE_ORANGE.copyWith(
                              color: ORANGE),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed("/login");
                            })
                    ])),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
