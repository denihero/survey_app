import 'package:flutter/material.dart';
import 'package:survey/core/constants/style.dart';

class UserSurveysCard extends StatelessWidget {
  const UserSurveysCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/pre_quiz'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const FittedBox(child: Placeholder()),
            title: Text(
              'Why people lie? ',
              style: Monsterats_500_15_FONT_SIZE_BLACK,
            ),
            subtitle: Text(
              '0/10 Questions',
              style: Monsterats_500_15_FONT_SIZE_BLACK,
            ),
          ),
        ),
      ),
    );
  }
}
