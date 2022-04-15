import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/bloc/login_api.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/presentation/navigation/routes.dart';
import 'package:survey/presentation/screens/setting/setting_screen.dart';

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
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          initialRoute: '/login',
          routes: App.route),
    );
  }
}
