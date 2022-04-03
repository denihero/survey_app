import 'package:flutter/material.dart';
import 'package:survey/core/constants/style.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return result(index);
          }),
    );
  }

  Widget result(int count) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(
            'Question: $count',
            style: Monsterats_500_15_FONT_SIZE_BLACK,
          ),
          SizedBox(
            width: 90,
          ),
          Text(
            'Answer',
            style: Monsterats_500_15_FONT_SIZE_BLACK,
          ),
        ],
      ),
    );
  }
}
