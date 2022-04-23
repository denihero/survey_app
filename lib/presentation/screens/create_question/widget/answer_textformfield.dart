import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnswerTextFormField extends StatelessWidget {
  const AnswerTextFormField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 1.h,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textCapitalization: TextCapitalization.sentences,
              cursorHeight: 20.sp,
              style: TextStyle(
                  fontSize: 14.sp
              ),
              decoration: InputDecoration(
                hintText: 'Answer',
                hintStyle:  TextStyle(
                    fontSize: 14.sp
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
                    width: 2.0.sp,
                  ),
                ),
              ),
            ),
          ),

          Visibility(
            child: SizedBox(
              width: 7.w,
              child: IconButton(
                icon: const Icon(Icons.add_circle),
                color:Colors.green,
                onPressed: () {},
              ),
            ),
          ),
          Visibility(
            child: SizedBox(
              width: 7.w,
              child: IconButton(
                icon: const Icon(Icons.remove_circle),
                color:Colors.red,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
