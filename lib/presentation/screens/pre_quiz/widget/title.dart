import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/cubit/current_survey_cubit.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.4,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 35,
            ),
            color: Colors.black,
            onPressed: () {
              BlocProvider.of<SurveyCurrentCubit>(context).answers =
                  <Questions, int>{};
              Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(
            title,
            // ignore: unnecessary_const
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ),
        ),
      ],
    );
  }
}
