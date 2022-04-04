import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/style.dart';

import '../pre_quiz_screen/widget/title.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key, this.title = "Something"}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //kinda appbar
              TitleWidget(
                title: title,
                icon: Icons.home,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "7/10 Question",
                style:
                    Monsterats_800_15_FONT_SIZE_ORANGE.copyWith(color: ORANGE),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 50,
              ),
              Flexible(
                child: Text(
                  "Hello Guys",
                  style: Monsterats_500_16_FONT_SIZE_BLACK,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Flexible(
                flex: 15,
                // height: 380,
                child: ListView(
                  children: [
                    Question(
                      question: "Hello",
                    ),
                    Question(
                      question: "Good",
                    ),
                    Question(
                      is_chosen: true,
                      question: "Right One",
                    ),
                    Question(
                      question: "Very Good",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 40,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  Question({Key? key, this.is_chosen = false, required this.question})
      : super(key: key);
  bool is_chosen;
  String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: BLUE,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.circle,
            color: is_chosen ? ORANGE : Colors.white,
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
