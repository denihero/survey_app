import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/choice_chip.dart';

class CategoryChoose extends StatefulWidget {
  const CategoryChoose({Key? key,}) : super(key: key);
  @override
  State<CategoryChoose> createState() => _CategoryChooseState();
}

class _CategoryChooseState extends State<CategoryChoose> {

  final _choices = [
    'Work','Food','Job','Mood','Sport','Programming'
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/13,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _choices.length,
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.all(5.0),
            child: ChoiceChipWidget(choices: _choices, index: index,)
          );
        }),
    );
  }
}
