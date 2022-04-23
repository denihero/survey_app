import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuestionTextFormField extends StatelessWidget {
  const QuestionTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.bottom,
      textCapitalization: TextCapitalization.sentences,
      cursorHeight: 14.sp,
      style: TextStyle(
          fontSize: 13.sp
      ),
      decoration: InputDecoration(
        hintText: 'Question',
        hintStyle: TextStyle(
            fontSize: 13.sp
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0.w,
          ),
        ),
      ),
    );
  }
}
