import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/cubit/like_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/home/widget/user_survey_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Title
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              "Saved",
              style: Monsterats_700_18_FONT_SIZE_BLACK,
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
                if (state.favorites.isEmpty) {
                  return const Center(
                    child: Text("Empty"),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.favorites.length,
                    // reverse: true,
                    itemBuilder: (context, index) {
                        final surveysMine =
                            BlocProvider.of<SurveyCubit>(context)
                                .state
                                .surveys
                                .where((element) =>
                                    element.author ==
                                    BlocProvider.of<AuthBloc>(context)
                                        .state
                                        .email)
                                .toList();
                        List keys = state.favorites.keys.toList();
                        return UserSurveyCard(
                          survey: keys[index],
                          is_saved: true,
                          isMine: surveysMine.contains(keys[index]),
                        );
                    },
                  ),
                );
              } else if (state is LikeError) {
                return const Center(
                  child: Text("Error.."),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
