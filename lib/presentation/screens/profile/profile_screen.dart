import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/setting/setting_screen.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/style.dart';
import 'widgets/profilecard.dart';
import 'widgets/profileicon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      width: 95,
                      child: Text(
                        "Profile",
                        style: Monsterats_600_18_FONT_SIZE_BLACK,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                     IconButton(
                      icon: const Icon(Icons.settings, size: 30,),
                      color: ORANGE, onPressed: () {
                       Navigator.of(context, rootNavigator: true).pushNamed('/setting');
                    },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              ProfileIcon(),
              SizedBox(
                height: 44,
              ),
              Center(
                  child: Text(
                "Username",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              )),
              SizedBox(
                height: 60,
              ),
              Text(
                "Your Survey:",
                style: Monsterats_600_18_FONT_SIZE_BLACK,
              ),
              SizedBox(
                height: 39,
              ),
              Expanded(
                child: ListView(
                  children: [
                    ProfileCard(
                        title: "Math for high school",
                        subtitle: "0/35 questions"),
                    ProfileCard(
                        title: "Math for high school",
                        subtitle: "0/35 questions"),
                    ProfileCard(
                        title: "Math for high school",
                        subtitle: "0/35 questions"),
                    ProfileCard(
                        title: "Math for high school",
                        subtitle: "0/35 questions"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
