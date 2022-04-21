import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';


class CreateQuestionScreen extends StatelessWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: BackButton(
            color: BLACK,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: const SafeArea(
        child: Text(
          'Create Question Screen'
        ),
      ),
    );
  }
}
