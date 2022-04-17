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
      builder: (context, state) {
        if (state is SurveyError)
          return const Center(
            child: Text("Error..."),
          );
        if (state is SurveyCompleted) {
          final surveys = BlocProvider.of<SurveyCubit>(context).state.surveys;
          return ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: surveys.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return UserSurveyCard(
                  title: surveys[index].title!,
                  count: surveys[index].questions!.length,
                  image: surveys[index].image ?? "",
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
