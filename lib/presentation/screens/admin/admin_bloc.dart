import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:survey/presentation/screens/quiz/quiz_screen.dart';

class ListFieldFormBloc extends FormBloc<String, String> {
  final questions = ListFieldBloc<MemberFieldBloc, dynamic>(name: 'questions');

  ListFieldFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        questions,
      ],
    );
  }

  void addMember() {
    questions.addFieldBloc(MemberFieldBloc(
      name: 'member',
      question: TextFieldBloc(name: 'Question'),
      answers: ListFieldBloc(name: 'Answers'),
    ));
  }

  void removeMember(int index) {
    questions.removeFieldBlocAt(index);
  }

  void addHobbyToMember(int memberIndex) {
    questions.value[memberIndex].answers.addFieldBloc(TextFieldBloc());
  }

  void removeHobbyFromMember(
      {required int memberIndex, required int hobbyIndex}) {
    questions.value[memberIndex].answers.removeFieldBlocAt(hobbyIndex);
  }

  @override
  void onSubmitting() async {
    // Without serialization
    final clubV1 = Club(
      questions: questions.value.map<Member>((memberField) {
        return Member(
          question: memberField.question.value,
          answers: memberField.answers.value
              .map((hobbyField) => hobbyField.value)
              .toList(),
        );
      }).toList(),
    );

    print('clubV1');
    print(clubV1);

    // With Serialization
    final clubV2 = Club.fromJson(state.toJson());

    ('clubV2');
    print(clubV2);

    emitSuccess(
      canSubmitAgain: true,
      successResponse: const JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),
    );
  }
}

class MemberFieldBloc extends GroupFieldBloc {
  final TextFieldBloc question;
  final ListFieldBloc<TextFieldBloc, dynamic> answers;

  MemberFieldBloc({
    required this.question,
    required this.answers,
    String? name,
  }) : super(name: name, fieldBlocs: [question, answers]);
}

class Member {
  String? question;
  List<String?>? answers;

  Member({this.question, this.answers});

  Member.fromJson(Map<String, dynamic> json) {
    print("Member 1");
    print(json);
    question = json['Question'];
    print("Member 2");
    print(question);
    answers = json['Answers'].cast<String>();
    print("Member 3");
    print(answers);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['questions'] = this.question;
    data['answers'] = this.answers;
    return data;
  }

  @override
  String toString() => '''Member {
  question: $question,
  answer: $answers
}''';
}

class Club {
  List<Member>? questions;

  Club({this.questions});

  Club.fromJson(Map<String, dynamic> json) {
    print("Debug");
    print(json);
    if (json['questions'] != null) {
      print("Inside");
      questions = <Member>[];
      json['questions'].forEach((v) {
        print("V:");
        print(v);
        questions!.add(Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '''Club {
  questions: $questions
}''';
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(color: Colors.black,),
          ),
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final int memberIndex;
  final MemberFieldBloc memberField;

  final VoidCallback onRemoveMember;
  final VoidCallback onAddHobby;

  const MemberCard({
    Key? key,
    required this.memberIndex,
    required this.memberField,
    required this.onRemoveMember,
    required this.onAddHobby,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Question #${memberIndex + 1}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: onRemoveMember,
                ),
              ],
            ),
            TextFieldBlocBuilder(
              textFieldBloc: memberField.question,
              decoration: const InputDecoration(
                labelText: 'Question',
              ),
            ),
            BlocBuilder<ListFieldBloc<TextFieldBloc, dynamic>,
                ListFieldBlocState<TextFieldBloc, dynamic>>(
              bloc: memberField.answers,
              builder: (context, state) {
                if (state.fieldBlocs.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.fieldBlocs.length,
                    itemBuilder: (context, i) {
                      final hobbyFieldBloc = state.fieldBlocs[i];
                      return Card(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: hobbyFieldBloc,
                                decoration: InputDecoration(
                                  labelText: 'Answer #${i + 1}',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.green,
                              ),
                              onPressed: () =>
                                  memberField.answers.removeFieldBlocAt(i),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
            TextButton(
              onPressed: onAddHobby,
              child: const Text(
                'ADD ANSWER',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
