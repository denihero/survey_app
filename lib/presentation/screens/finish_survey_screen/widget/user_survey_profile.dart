import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';

class UserSurveyProfileWidget extends StatelessWidget {
  const UserSurveyProfileWidget({Key? key}) : super(key: key);

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
              child: Placeholder(
            color: WHITE,
          )),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text('Jamesalicon',
                style:
                    Monsterats_600_16_FONT_SIZE_BLACK.copyWith(color: WHITE)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'See more survey',
              style: Monsterats_600_16_FONT_SIZE_GREY,
            ),
          ),
          trailing: SizedBox(
            width: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
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
      ),
    );
  }
}
