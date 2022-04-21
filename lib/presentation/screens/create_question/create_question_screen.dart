import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/create_question/widget/answer_textformfield.dart';
import 'package:survey/presentation/screens/create_question/widget/question_formfield.dart';


class CreateQuestionScreen extends StatelessWidget {
  CreateQuestionScreen({Key? key}) : super(key: key);
  final List<AnswerTextFormField> answerTextFormField = [];

  void addTextFormField() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: BackButton(
            color: BLACK,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
             Align(
               alignment: Alignment.topLeft,
               child: Padding(
                 padding: EdgeInsets.only(
                   top: MediaQuery.of(context).size.width * 0.07,
                   left: MediaQuery.of(context).size.width * 0.06,
                   bottom: MediaQuery.of(context).size.width * 0.03,
                 ),
                 child: Text(
                    'Write your questions',
                    style: Monsterats_500_18_FONT_SIZE_BLACK,
            ),
               ),
             ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: const QuestionTextFormField(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.09,
                  left: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Text(
                  'Possible Answer',
                  style: Monsterats_500_18_FONT_SIZE_BLACK,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.020,
                ),
                child:ListView.builder(
                  itemCount: answerTextFormField.length,
                  itemBuilder: (context, index) {
                    return const AnswerTextFormField();
                  }),
              ),
            ),
          ],
        )
      ),
    );
  }
}
