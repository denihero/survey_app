import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/navigation/routes.dart';
import 'package:flutter/services.dart';
import 'logic/cubit/current_survey_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
    () => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(const MyApp())),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          lazy: true,
          create: (context) => AuthBloc(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(),
        ),
        BlocProvider<SurveyCubit>(
          create: (context) => SurveyCubit(),
        ),
        BlocProvider<SurveyCurrentCubit>(
          create: (context) => SurveyCurrentCubit(),
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
