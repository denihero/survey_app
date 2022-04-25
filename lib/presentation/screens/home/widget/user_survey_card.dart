import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/bloc/login_api.dart';
import 'package:survey/logic/cubit/current_survey_cubit.dart';
import 'package:survey/logic/cubit/like_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/pre_quiz/pre_quiz_screen.dart';

import '../../../../core/models/survey.dart';

class UserSurveyCard extends StatefulWidget {
  UserSurveyCard({
    Key? key,
    required this.survey,
    this.isMine = false,
    this.is_saved = false,
  }) : super(key: key);
  final Surveys survey;
  final bool isMine;
  bool is_saved;

  @override
  State<UserSurveyCard> createState() => _UserSurveyCardState();
}

class _UserSurveyCardState extends State<UserSurveyCard> {
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
                : CachedNetworkImage(
                    imageUrl: widget.survey.image ?? "",
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
            // : Image.network(
            //     widget.survey.image ?? "",
            //     fit: BoxFit.cover,
            //     height: 60,
            //     width: 60,
            //   ),
            title: Text(
              widget.survey.title ?? "",
              style: Monsterats_500_15_FONT_SIZE_BLACK,
            ),
            subtitle: Text(
              'Quesions: ${widget.survey.questions?.length ?? 0}',
              style: Monsterats_500_15_FONT_SIZE_BLACK,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  color: widget.is_saved ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(
                      () {
                        if (!widget.is_saved) {
                          widget.is_saved = true;
                          BlocProvider.of<LikeCubit>(context).add_like(
                              widget.survey,
                              BlocProvider.of<AuthBloc>(context).state.token);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Added to favorites")));
                        } else {
                          widget.is_saved = false;
                          BlocProvider.of<LikeCubit>(context).delete_likes(
                              widget.survey,
                              BlocProvider.of<AuthBloc>(context).state.token);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 7,
                ),
                widget.isMine
                    ? IconButton(
                        onPressed: () async {
                          try {
                            await delete_survey(widget.survey.id,
                                BlocProvider.of<AuthBloc>(context).state.token);
                            BlocProvider.of<SurveyCubit>(context)
                                .delete_survey(widget.survey);
                          } catch (_) {
                            print("delete survey Error");
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                        ),
                      )
                    : const Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
