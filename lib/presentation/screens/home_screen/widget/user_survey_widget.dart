import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/user_survey_card.dart';

class UserSurveyWidget extends StatefulWidget {
  const UserSurveyWidget({Key? key,}) : super(key: key);

  @override
  State<UserSurveyWidget> createState() => _UserSurveyWidgetState();
}

class _UserSurveyWidgetState extends State<UserSurveyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 8,
          itemBuilder: (context, index) {
            return const UserSurveyCard(title: 'Adam Sendler', count: 12);
          }),
    );
  }
}
