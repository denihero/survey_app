import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
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
    if (current_question >= 0) {
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
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
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

class question extends StatelessWidget {
  final int index;
  int chosen_index = -1;
  question({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final survey = BlocProvider.of<SurveyCurrentCubit>(context).state;
    final max = survey!.questions?.length;
    return index <= max! - 1
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
                  "${index + 1}/${survey.questions?.length} Question",
                  style: Monsterats_800_15_FONT_SIZE_ORANGE.copyWith(
                      color: ORANGE),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 50,
                ),
                Flexible(
                  child: Text(
                    survey.questions?[index].text ?? "",
                    style: Monsterats_500_16_FONT_SIZE_BLACK,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Flexible(
                  flex: 15,
                  // height: 380,
                  child: ListView(
                    children: survey.questions![index].choices
                            ?.map(
                              (e) => Question(
                                question: e.text ?? "",
                                isChosen: e.id == chosen_index,
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
                      // Navigator.of(context).
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const MainPage(
                      //             is_begin: true,
                      //           )),
                      // );
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    },
                    child: const Text("Go back to Home Screen"))
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
          onTap: () {},
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
