import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/home/widget/user_survey_card.dart';

class UserSurveyWidget extends StatefulWidget {
  const UserSurveyWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserSurveyWidget> createState() => _UserSurveyWidgetState();
}

class _UserSurveyWidgetState extends State<UserSurveyWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(
      //  buildWhen: (previous, current) {
      //    print(previous.surveys.last.title != current.surveys.last.title);
      //    return previous.surveys.last.title != current.surveys.last.title;
      // },
      builder: (context, state) {
        if (state is SurveyEmpty) {
          return const Center(
            child: Text("Nothing to show yet!"),
          );
        }

        else if (state is SurveyError) {
          return const Center(
            child: Text("Error..."),
          );
        }
        else if (state is SurveyCompleted) {
          final surveys = BlocProvider.of<SurveyCubit>(context).state.surveys;
          return ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: surveys.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return UserSurveyCard(
                  survey: surveys[index],
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
