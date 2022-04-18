import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/users_survey/widget/appbar_widget.dart';
import 'package:survey/presentation/screens/users_survey/widget/user_profile.dart';
import 'package:survey/presentation/screens/users_survey/widget/user_survey.dart';

class UserSurveyScreen extends StatefulWidget {
  const UserSurveyScreen({Key? key}) : super(key: key);

  @override
  State<UserSurveyScreen> createState() => _UserSurveyScreenState();
}

class _UserSurveyScreenState extends State<UserSurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const CustomAppbarWidget(),
          body: SingleChildScrollView(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(child: UserProfileWidget()),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: UserSurvey(),
                )
              ],
            ),
          ),
        ));
  }
}
