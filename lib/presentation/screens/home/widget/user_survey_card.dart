import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/cubit/current_survey_cubit.dart';
import 'package:survey/presentation/screens/pre_quiz/pre_quiz_screen.dart';

import '../../../../core/models/survey.dart';

class UserSurveyCard extends StatefulWidget {
  const UserSurveyCard({Key? key, required this.survey}) : super(key: key);
  final Surveys survey;

  @override
  State<UserSurveyCard> createState() => _UserSurveyCardState();
}

class _UserSurveyCardState extends State<UserSurveyCard> {
  bool? isSaved = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SurveyCurrentCubit>(context).set_current(widget.survey);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PreQuizScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: widget.survey.image == null
                ? const FittedBox(child: Placeholder())
                : Image.network(
                    widget.survey.image ?? "",
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
            title: Text(
              widget.survey.title ?? "",
              style: Monsterats_500_15_FONT_SIZE_BLACK,
            ),
            subtitle: Text(
              'Survey: ${widget.survey.questions?.length ?? 0}',
              style: Monsterats_500_15_FONT_SIZE_BLACK,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                size: 30,
              ),
              color: isSaved! ? Colors.black : Colors.grey,
              onPressed: () {
                setState(() {
                  if (!isSaved!) {
                    isSaved = true;
                  } else {
                    isSaved = false;
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
