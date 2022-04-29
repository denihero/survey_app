import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/home/widget/user_survey_card.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/style.dart';
import '../../../logic/bloc/auth_bloc.dart';

import '../../../logic/cubit/cubit/post_cubit.dart';
import '../../../logic/cubit/like_cubit.dart';
import 'widgets/profileicon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final x = context.watch<LikeCubit>();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 50, bottom: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          SizedBox(
                            width: 95,
                            child: Text(
                              "Profile",
                              style: Monsterats_600_18_FONT_SIZE_BLACK.copyWith(
                                  fontSize: 20),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              size: 30,
                            ),
                            color: ORANGE,
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed('/setting');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    ProfileIcon(),
                    const SizedBox(
                      height: 44,
                    ),
                    Center(
                        child: Text(
                      "${BlocProvider.of<AuthBloc>(context).state.name} ${BlocProvider.of<AuthBloc>(context).state.surname}",
                      style: Monsterats_600_18_FONT_SIZE_BLACK,
                    )),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        "Your Surveys:",
                        style: Monsterats_600_18_FONT_SIZE_BLACK,
                      ),
                    ),
                    const SizedBox(
                      height: 39,
                    ),
                    BlocBuilder<SurveyMineCubit, SurveyMine>(
                      // buildWhen: (previous, current) {
                      //   bool x = BlocProvider.of<LikeCubit>(context)
                      //       .state
                      //       .favorites
                      //       .isNotEmpty;
                      //   return x;
                      // },
                      builder: (context, state) {
                        if (state is SurveyMineEmpty) {
                          return const Center(
                            child: Text("Empty"),
                          );
                        } else if (state is SurveyMineError) {
                          return const Center(
                            child: Text("Error..."),
                          );
                        } else if (state is SurveyMineCompleted) {
                          final surveys = state.surveys;
                          return ListView.builder(
                              // reverse: true,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              // scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.hasReachedMax
                                  ? surveys.length
                                  : surveys.length + 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index < surveys.length) {
                                  bool isSaved =
                                      BlocProvider.of<LikeCubit>(context)
                                          .state
                                          .favorites
                                          .containsKey(surveys[index]);
                                  return UserSurveyCard(
                                    survey: surveys[index],
                                    isMine: true,
                                    is_saved: isSaved,
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                );
                              });
                        }
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'admin',
            backgroundColor: ORANGE,
            child: const Icon(
              Icons.add,
              color: WHITE,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/admin');
            },
          ),
        ));
  }
}
