import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/choice_chip_widget.dart';

class CategoryChooseWidget extends StatefulWidget {
  const CategoryChooseWidget({Key? key,}) : super(key: key);
  @override
  State<CategoryChooseWidget> createState() => _CategoryChooseState();
}

class _CategoryChooseState extends State<CategoryChooseWidget> {

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
