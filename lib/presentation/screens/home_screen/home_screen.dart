import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/appBar/appbar.dart';
import 'package:survey/presentation/screens/home_screen/widget/category_choose_widget.dart';
import 'package:survey/presentation/screens/home_screen/widget/user_survey_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppbarWidget(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Padding(
                    padding: EdgeInsets.only(left: 15,top: 10),
                    child:CategoryChooseWidget()
                ),
                UserSurveyWidget(),
              ],
            ),
          )),
    );
  }
}