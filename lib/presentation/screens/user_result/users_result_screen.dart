import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/presentation/screens/usert_attempt/widget/result_widget.dart';

class UserResultScreen extends StatelessWidget {
  const UserResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: BLACK,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 77,
                ),
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: ORANGE,
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  'username',
                  style: Monsterats_500_18_FONT_SIZE_BLACK.copyWith(
                      fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  'Result',
                  style: Monsterats_600_24_FONT_SIZE_BLACK,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, top: 25),
                  child: ResultWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
