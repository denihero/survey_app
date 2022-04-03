import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 80,
        height: 31,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ORANGE),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: ORANGE)))),
            onPressed: () {},
            child: Text(
              'Follow',
              style: Monsterats_600_13_FONT_SIZE_WHITE,
            )));
  }
}
