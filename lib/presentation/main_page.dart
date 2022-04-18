import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/presentation/screens/favourite/favourite_screen.dart';
import 'package:survey/presentation/screens/finish_survey/finish_survey_screen.dart';
import 'package:survey/presentation/screens/home/home_screen.dart';
import 'package:survey/presentation/screens/login/login_screen.dart';
import 'package:survey/presentation/screens/pre_quiz/pre_quiz_screen.dart';
import 'package:survey/presentation/screens/profile/profile_screen.dart';
import 'package:survey/presentation/screens/quiz/quiz_screen.dart';

import 'package:survey/presentation/screens/user_result/users_result_screen.dart';
import 'package:survey/presentation/screens/users_survey/user_survey_screen.dart';
import 'package:survey/presentation/screens/usert_attempt/users_attempt_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  final _screens = <Widget>[
    HomeScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  int _currentIndex = 0;

  void _onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
          onGenerateRoute: (setting) {
            if (setting.name == '/') {
              return MaterialPageRoute(
                  builder: (_) => IndexedStack(
                        children: _screens,
                        index: _currentIndex,
                      ));
            } else if (setting.name == '/favourite') {
              return MaterialPageRoute(builder: (_) => const FavouriteScreen());
            } else if (setting.name == '/user_survey') {
              return MaterialPageRoute(
                  builder: (_) => const UserSurveyScreen());
            } else if (setting.name == '/favourite') {
              return MaterialPageRoute(builder: (_) => const FavouriteScreen());
            } else if (setting.name == '/pre_quiz') {
              return MaterialPageRoute(builder: (_) => PreQuizScreen());
            } else if (setting.name == '/user_attempt') {
              return MaterialPageRoute(
                  builder: (_) => const UserAttemptScreen());
            } else if (setting.name == '/user_result') {
              return MaterialPageRoute(
                  builder: (_) => const UserResultScreen());
            } else if (setting.name == '/finish_survey') {
              return MaterialPageRoute(
                  builder: (_) => const FinishSurveyScreen());
            } else if (setting.name == '/profile') {
              return MaterialPageRoute(builder: (_) => const ProfileScreen());
            } else if (setting.name == '/login') {
              return MaterialPageRoute(builder: (_) => LoginScreen());
            } else if (setting.name == "/quiz") {
              return MaterialPageRoute(builder: (_) => QuizScreen());
            }
          },
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(21),
              topRight: Radius.circular(21),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21), topRight: Radius.circular(21)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: const IconThemeData(color: BLUE),
              unselectedItemColor: BLACK,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 35,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_sharp,
                    size: 35,
                  ),
                  label: '',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: BLUE,
              onTap: _onTap,
            ),
          ),
        ));
  }
}
