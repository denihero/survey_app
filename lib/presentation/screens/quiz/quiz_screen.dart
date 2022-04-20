import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/cubit/current_survey_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/main_page.dart';
import 'package:survey/presentation/screens/pre_quiz/widget/title.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, this.title = "Something"}) : super(key: key);
  final String title;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int current_question = 0;

  void go_next() {
    setState(() {
      current_question += 1;
    });
  }

  void go_back() {
    if (current_question > 0) {
      setState(() {
        current_question -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final max =
        BlocProvider.of<SurveyCurrentCubit>(context).state?.questions?.length;

    return SafeArea(
      child: Container(
        // height: 500,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //kinda appbar
            question(index: current_question),
            current_question <= max! - 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: go_back,
                        child: const Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.arrow_back,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: go_next,
                        child: const Card(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 40,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : const Text(""),
          ],
        ),
      ),
    );
  }
}

class question extends StatefulWidget {
  final int index;
  // int chosen_index = -1;
  question({required this.index, Key? key}) : super(key: key);

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {
  List<int> chosen_index = List<int>.filled(20, 0);

  @override
  Widget build(BuildContext context) {
    final survey = BlocProvider.of<SurveyCurrentCubit>(context).state;
    final max = survey!.questions?.length;
    return widget.index <= max! - 1
        ? Expanded(
            child: Column(
              children: [
                TitleWidget(
                  title: survey.title ?? "",
                  icon: Icons.home,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "${widget.index + 1}/${survey.questions?.length} Question",
                  style: Monsterats_800_15_FONT_SIZE_ORANGE.copyWith(
                      color: ORANGE),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  survey.questions?[widget.index].text ?? "",
                  style: Monsterats_500_16_FONT_SIZE_BLACK,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  flex: 15,
                  // height: 380,
                  child: ListView(
                    children: survey.questions![widget.index].choices
                            ?.map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    chosen_index[widget.index] = e.id ?? 0;
                                  });
                                  BlocProvider.of<SurveyCurrentCubit>(context)
                                              .answers[
                                          survey.questions![widget.index]] =
                                      chosen_index[widget.index];
                                },
                                child: Question(
                                  question: e.text ?? "",
                                  isChosen: chosen_index[widget.index] == e.id,
                                ),
                              ),
                            )
                            .toList() ??
                        <Question>[],
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          )
        : Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text("That is it,Thank you for participation"),
                ),
                TextButton(
                  onPressed: () {
                    String email =
                        BlocProvider.of<AuthBloc>(context).state.email;
                    var survey =
                        BlocProvider.of<SurveyCurrentCubit>(context).state;
                    int survey_index = BlocProvider.of<SurveyCubit>(context)
                            .state
                            .surveys
                            .indexOf(survey!) +1
                        ;
                    BlocProvider.of<SurveyCurrentCubit>(context)
                        .post_submissions(email, survey_index);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: const Text("Go back to Home Screen"),
                ),
              ],
            ),
          );
  }
}

class Question extends StatelessWidget {
  const Question({Key? key, this.isChosen = false, required this.question})
      : super(key: key);
  final bool isChosen;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: BLUE,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: GestureDetector(
          child: Icon(
            Icons.circle,
            color: isChosen ? ORANGE : Colors.white,
            size: 44,
          ),
        ),
        title: Text(
          question,
          style:
              Monsterats_500_16_FONT_SIZE_BLACK.copyWith(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
