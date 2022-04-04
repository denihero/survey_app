import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/login_screen/login_screen.dart';
import 'logic/bloc/auth_bloc.dart';
import 'presentation/main_page.dart';
import 'presentation/screens/favourite_screen/favourite_screen.dart';
import 'presentation/screens/pre_quiz_screen/pre_quiz_screen.dart';
import 'presentation/screens/profile_screen/profile_screen.dart';
import 'presentation/screens/quiz_screen/quiz_screen.dart';
import 'presentation/screens/setting_screen/setting_screen.dart';
import 'presentation/screens/users_survey_screen/user_survey_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/login': (context) => LoginScreen(),
          '/favourite': (context) => const FavouriteScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/quiz': (context) => QuizScreen(),
          '/setting': (context) => const SettingScreen(),
          '/user_survey': (context) => const UserSurveyScreen(),
          '/pre_quiz': (context) => const PreQuizScreen(
              title: 'Basic of programming',
              description: 'It\'all about programming')
        },
      ),
    );
  }
}
