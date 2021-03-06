import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/logic/cubit/current_survey_cubit.dart';

import '../../../logic/bloc/auth_bloc.dart';
import '../quiz/quiz_screen.dart';
import 'widget/title.dart';

class PreQuizScreen extends StatelessWidget {
  PreQuizScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final survey = BlocProvider.of<SurveyCurrentCubit>(context).state;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //kinda appbar
                  TitleWidget(
                    title: survey?.title ?? "",
                    icon: Icons.home,
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    survey?.title ?? "",
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Author: ${ BlocProvider.of<AuthBloc>(context).state.email==survey?.author?"Me":survey?.author}",
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Divider(
                    thickness: 2,
                    height: 35,
                    color: Colors.black54,
                  ),
                  //description of the course
                  Text(
                    survey?.description ?? "Description",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const QuizScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(9)),
                      child: const Center(
                        child: Text(
                          "Start",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                        // color: WHITE,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
