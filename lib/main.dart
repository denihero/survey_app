import 'package:flutter/material.dart';
import 'package:survey/presentation/main_page.dart';
import 'package:survey/presentation/screens/favourite/favourite_screen.dart';
import 'package:survey/presentation/screens/finish_survey/finish_survey_screen.dart';
import 'package:survey/presentation/screens/pre_quiz/pre_quiz_screen.dart';
import 'package:survey/presentation/screens/profile/profile_screen.dart';
import 'package:survey/presentation/screens/quiz/quiz_screen.dart';
import 'package:survey/presentation/screens/setting/setting_screen.dart';
import 'package:survey/presentation/screens/user_result/users_result_screen.dart';

import 'package:survey/presentation/screens/users_survey/user_survey_screen.dart';
import 'package:survey/presentation/screens/usert_attempt/users_attempt_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/favourite': (context) => const FavouriteScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/quiz': (context) => QuizScreen(),
        '/setting': (context) => const SettingScreen(),
        '/user_survey': (context) => const UserSurveyScreen(),
        '/pre_quiz': (context) => const PreQuizScreen(
            title: 'Basic of programming',
            description: 'It\'all about programming'),
        '/finish_survey': (context) => const FinishSurveyScreen(),
        '/user_attempt': (context) => const UserAttemptScreen(),
        '/user_result': (context) => const UserResultScreen()
      },
    );
  }
}
