import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/profile_screen/widgets/profileicon.dart';
import 'package:survey/presentation/screens/setting_screen/widgets/profile_edit_icon.dart';

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
              const ProfileEditIcon(),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Name",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              ),
              Text(
                "Username",
                style: Monsterats_500_13_FONT_SIZE_BLACK,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "email",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              ),
              Text(
                "baibaitur@gmail.com",
                style: Monsterats_500_13_FONT_SIZE_BLACK,
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    "Logout",
                    style: Monsterats_600_18_FONT_SIZE_BLACK,
                  ),
                ],
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