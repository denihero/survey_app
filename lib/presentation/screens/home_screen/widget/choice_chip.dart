import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';

class ChoiceChipWidget extends StatefulWidget {
  const ChoiceChipWidget({Key? key,required this.choices,required this.index,}) : super(key: key);
  final List choices;
  final int index;

  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  int? choiceIndex;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        widget.choices[widget.index],
      ),
      backgroundColor: WHITE,
      selectedColor: ORANGE,
      selected: choiceIndex == widget.index,
      elevation: 5,
      shadowColor: BLACK,
      labelStyle: choiceIndex != null ? Monsterats_600_13_FONT_SIZE_WHITE:Monsterats_600_13_FONT_SIZE_BLACK,
      onSelected: (isSelected) {
        setState(() {
          if(isSelected){
            choiceIndex = widget.index;
          }else{
            choiceIndex = null;
          }
        });
      },

    );
  }
}
