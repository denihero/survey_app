import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/users_survey/widget/follow_button.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        color: BLUE,
        child: ListTile(
          leading: const FittedBox(
              alignment: Alignment.bottomCenter,
              child: Placeholder(
                color: WHITE,
              )),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Jamesalicon',
                    style: Monsterats_600_16_FONT_SIZE_BLACK.copyWith(
                        color: WHITE)),
                const Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: FollowButton(),
                ),
              ],
            ),
          ),
          trailing: SizedBox(
            width: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('.', style: TextStyle(fontSize: 17, color: WHITE)),
                Text('.', style: TextStyle(fontSize: 17, color: WHITE)),
                Text('.', style: TextStyle(fontSize: 17, color: WHITE)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
