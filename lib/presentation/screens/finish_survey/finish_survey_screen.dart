import 'package:flutter/material.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/finish_survey/widget/author_tile.dart';
import 'package:survey/presentation/screens/finish_survey/widget/user_survey_profile.dart';

class FinishSurveyScreen extends StatefulWidget {
  const FinishSurveyScreen({Key? key}) : super(key: key);

  @override
  State<FinishSurveyScreen> createState() => _FinishSurveyScreenState();
}

class _FinishSurveyScreenState extends State<FinishSurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              'Basis Programming',
              style: Monsterats_600_13_FONT_SIZE_BLACK,
            ),
            const SizedBox(
              height: 80,
            ),
            const UserSurveyProfileWidget(),
            const SizedBox(
              height: 44,
            ),
            Text(
              'Thanks for your activiti!',
              style: Monsterats_600_16_FONT_SIZE_BLACK,
            ),
            const SizedBox(
              height: 56,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Text(
                  'More from author:',
                  style: Monsterats_500_16_FONT_SIZE_BLACK,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const AuthorTileWidget(),
            const AuthorTileWidget(),
          ],
        ),
      ),
    );
  }
}
