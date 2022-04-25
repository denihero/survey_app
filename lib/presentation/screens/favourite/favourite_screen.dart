import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/cubit/like_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/home/widget/user_survey_card.dart';
import 'package:survey/presentation/screens/users_survey/widget/user_survey.dart';

import '../../../core/models/survey.dart';
import '../favourite/widget/card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 0),
      child: Column(
        children: [
          //Title
          const Center(
            child: Text(
              "Saved",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          BlocBuilder<LikeCubit, LikeState>(
            builder: (context, state) {
              if (state is LikeEmpty) {
                return const Center(
                  child: Text("Empty"),
                );
              } else if (state is LikeSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.favorites.length,
                    // reverse: true,
                    itemBuilder: (context, index) {

                      final surveysMine = BlocProvider.of<SurveyCubit>(context)
                          .state
                          .surveys
                          .where((element) =>
                              element.author ==
                              BlocProvider.of<AuthBloc>(context).state.email)
                          .toList();
                      List keys = state.favorites.keys.toList();
                      return UserSurveyCard(
                        survey: keys[index],
                        is_saved: true,
                        isMine: surveysMine.contains(keys[index]),
                      );
                    },
                    // Saved Cards
                    // children: const [
                    //   InfoCard(
                    //       title: "Math for high school",
                    //       subtitle: "0/35 Questions",
                    //       isSaved: true),
                    //   InfoCard(
                    //       title: "Math for high school",
                    //       subtitle: "0/35 Questions",
                    //       isSaved: true),
                    //   InfoCard(
                    //       title: "Math for high school",
                    //       subtitle: "0/35 Questions",
                    //       isSaved: true),
                    //   InfoCard(
                    //       title: "Math for high school",
                    //       subtitle: "0/35 Questions",
                    //       isSaved: true),
                    // ],
                  ),
                );
              } else if (state is LikeError) {
                return const Center(
                  child: Text("Error.."),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    ));
  }
}
