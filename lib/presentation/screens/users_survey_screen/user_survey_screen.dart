import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/favourite_screen/favourite_screen.dart';
import 'package:survey/presentation/screens/home_screen/home_screen.dart';
import 'package:survey/presentation/screens/home_screen/widget/appBar/bottom_appbar_widget.dart';
import 'package:survey/presentation/screens/profile_screen/profile_screen.dart';
import 'package:survey/presentation/screens/users_survey_screen/widget/appbar_widget.dart';
import 'package:survey/presentation/screens/users_survey_screen/widget/user_profile.dart';
import 'package:survey/presentation/screens/users_survey_screen/widget/user_survey.dart';

class UserSurveyScreen extends StatefulWidget {
  const UserSurveyScreen({Key? key}) : super(key: key);

  @override
  State<UserSurveyScreen> createState() => _UserSurveyScreenState();
}

class _UserSurveyScreenState extends State<UserSurveyScreen> {
  final _widgetOptions = <Widget>[
    const HomeScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  late int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      bottomNavigationBar:
          BottomWidget(selectedIndex: _selectedIndex, onTap: _onItemTapped),
    ));
  }
}
