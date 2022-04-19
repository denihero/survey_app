import 'package:flutter/cupertino.dart';
import 'package:survey/presentation/screens/favourite/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:survey/presentation/main_page.dart';
import 'package:survey/presentation/screens/finish_survey/finish_survey_screen.dart';
import 'package:survey/presentation/screens/home/home_screen.dart';
import 'package:survey/presentation/screens/login/login_screen.dart';
import 'package:survey/presentation/screens/pre_quiz/pre_quiz_screen.dart';
import 'package:survey/presentation/screens/profile/profile_screen.dart';
import 'package:survey/presentation/screens/quiz/quiz_screen.dart';
import 'package:survey/presentation/screens/setting/setting_screen.dart';
import 'package:survey/presentation/screens/user_result/users_result_screen.dart';
import 'package:survey/presentation/screens/users_survey/user_survey_screen.dart';
import 'package:survey/presentation/screens/usert_attempt/users_attempt_screen.dart';

import '../main_page.dart';

class App {
  static final route = <String, WidgetBuilder>{
    '/': (context) => const MainPage(),
    '/home': (context) => const HomeScreen(),
    '/favourite': (context) => const FavouriteScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/quiz': (context) => const QuizScreen(),
    '/setting': (context) => const SettingScreen(),
    '/user_survey': (context) => const UserSurveyScreen(),
    '/pre_quiz': (context) => PreQuizScreen(),
    '/finish_survey': (context) => const FinishSurveyScreen(),
    '/user_attempt': (context) => const UserAttemptScreen(),
    '/user_result': (context) => const UserResultScreen(),
    '/login': (context) => LoginScreen(),
  };
}
