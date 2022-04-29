import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/cubit/like_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/home/widget/user_survey_card.dart';

import '../../../../logic/bloc/auth_bloc.dart';

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
    final x = context.watch<LikeCubit>();

    return BlocBuilder<SurveyCubit, SurveyState>(
      // buildWhen: (previous, current) {
      //   print(x.state.favorites.isNotEmpty);
      //   return x.state.favorites.isNotEmpty;
      // },
      builder: (context, state) {
        if (state is SurveyEmpty) {
          return const Center(
            child: Text("Nothing to show yet!"),
          );
        } else if (state is SurveyError) {
          return const Center(
            child: Text("Error..."),
          );
        } else if (state is SurveyCompleted) {
          final surveys = BlocProvider.of<SurveyCubit>(context).state.surveys;
          return ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            reverse: true,
            itemCount: surveys.length,
            
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final surveysMine = BlocProvider.of<SurveyCubit>(context)
                  .state
                  .surveys
                  .where((element) =>
                      element.author ==
                      BlocProvider.of<AuthBloc>(context).state.email)
                  .toList();
              bool isSaved = BlocProvider.of<LikeCubit>(context)
                  .state
                  .favorites
                  .containsKey(surveys[index]);
              return UserSurveyCard(
                survey: surveys[index],
                // isMine: isMine,
                is_saved: isSaved,
                isMine: surveysMine.contains(surveys[index]),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator(color: Colors.black,));
      },
    );
  }
}
