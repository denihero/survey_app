import 'package:flutter/material.dart';
import 'package:survey/core/constants/style.dart';

class UserSurveysCard extends StatelessWidget {
  const UserSurveysCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/pre_quiz'),
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const FittedBox(
                alignment: Alignment.bottomLeft, child: Placeholder()),
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Why people lie? ',
                style: Monsterats_500_15_FONT_SIZE_BLACK,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '0/10 Questions',
                style: Monsterats_500_15_FONT_SIZE_BLACK,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
