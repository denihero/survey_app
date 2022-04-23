import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/create_question/widget/answer_textformfield.dart';
import 'package:survey/presentation/screens/create_question/widget/question_formfield.dart';
import 'package:sizer/sizer.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final List<AnswerTextFormField> answerTextFormField = [];

  void addTextFormField() {
  setState(() {
    answerTextFormField.add( AnswerTextFormField());
  });
  }
  
  void deleteCurrentTFF(int index){
    setState(() {
      answerTextFormField.removeAt(index);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.sp,
            ),
            child: IconButton(
                onPressed:() {

                },
                icon: const Icon(
                    Icons.check,
                color:  BLACK ,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(
            top: 10.sp,
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
                    top: 10.w,
                    left: 2.5.h,
                    bottom: 3.w,
                  ),
                  child: Text(
                    'Write your questions',
                    style: Monsterats_500_18_FONT_SIZE_BLACK,
                  ),
                ),
              ),
              SizedBox(
                width: 90.w,
                height: 6.h,
                child: const QuestionTextFormField(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8.w,
                    left: 2.5.h,
                  ),
                  child: Text(
                    'Possible Answer',
                    style: Monsterats_500_18_FONT_SIZE_BLACK,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: answerTextFormField.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const AnswerTextFormField(),
                          IconButton(
                              icon: const Icon(Icons.remove_circle,color: Colors.red,),
                              onPressed: () => deleteCurrentTFF(index)
                          )
                        ],
                      );
                    }),
              ),
              ElevatedButton(
                child: Text('Next Question'),
                onPressed: () {},
              ),

              ElevatedButton(
                  onPressed: () => addTextFormField(),
                  child: const Text('add')
              ),

            ],
          )
      ),
    );
  }
}

