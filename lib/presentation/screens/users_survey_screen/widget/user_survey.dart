import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/users_survey_screen/widget/user_surveys_card_widget.dart';

class UserSurvey extends StatelessWidget {
  const UserSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const UserSurveysCard();
          }),
    );
  }
}
