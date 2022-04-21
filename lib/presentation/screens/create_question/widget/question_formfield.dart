import 'package:flutter/material.dart';

class QuestionTextFormField extends StatelessWidget {
  const QuestionTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.bottom,
      textCapitalization: TextCapitalization.sentences,
      cursorHeight: 20,
      style: const TextStyle(
          fontSize: 16
      ),
      decoration: InputDecoration(
        hintText: 'Question',
        hintStyle: const TextStyle(
            fontSize: 16
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
