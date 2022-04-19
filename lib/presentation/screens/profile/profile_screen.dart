import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/cubit/current_survey_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';
import 'package:survey/presentation/screens/home/widget/user_survey_card.dart';
import 'package:survey/presentation/screens/setting/setting_screen.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/style.dart';
import '../../../logic/bloc/auth_bloc.dart';
import 'widgets/profilecard.dart';
import 'widgets/profileicon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                      width: 95,
                      child: Text(
                        "Profile",
                        style: Monsterats_600_18_FONT_SIZE_BLACK,
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
                const SizedBox(
                  height: 27,
                ),
                ProfileIcon(),
                const SizedBox(
                  height: 44,
                ),
                Center(
                    child: Text(
                  BlocProvider.of<AuthBloc>(context).state.email,
                  style: Monsterats_600_18_FONT_SIZE_BLACK,
                )),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Your Surveys:",
                  style: Monsterats_600_18_FONT_SIZE_BLACK,
                ),
                const SizedBox(
                  height: 39,
                ),
                BlocBuilder<SurveyCubit, SurveyState>(
                    builder: (context, state) {
                  if (state is SurveyError) {
                    return const Center(
                      child: Text("Error..."),
                    );
                  }
                  if (state is SurveyCompleted) {
                    final surveys = BlocProvider.of<SurveyCubit>(context)
                        .state
                        .surveys
                        .where((element) =>
                            element.author ==
                            BlocProvider.of<AuthBloc>(context).state.email)
                        .toList();
                    return ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
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
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
