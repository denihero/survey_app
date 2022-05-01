import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/presentation/screens/setting/widgets/profile_edit_icon.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        backgroundColor: WHITE,
        iconTheme: const IconThemeData(
          color: BLACK, //change your color here
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
        title: Text(
          "Settings",
          style: Monsterats_600_18_FONT_SIZE_BLACK,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: WHITE,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 35, top: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ProfileEditIcon();
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Name",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              ),
              Text(
                BlocProvider.of<AuthBloc>(context).state.name,
                style: Monsterats_500_15_FONT_SIZE_BLACK,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Surname",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              ),
              Text(
                BlocProvider.of<AuthBloc>(context).state.surname,
                style: Monsterats_500_15_FONT_SIZE_BLACK,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "email",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              ),
              Text(
                BlocProvider.of<AuthBloc>(context).state.email,
                style: Monsterats_500_15_FONT_SIZE_BLACK,
              ),
              const SizedBox(
                height: 40,
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context).add(AuthLogout());
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                '/login', (route) => false);
                      },
                      child: Text(
                        "Logout",
                        style: Monsterats_600_18_FONT_SIZE_BLACK,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
