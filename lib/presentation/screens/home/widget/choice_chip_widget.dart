import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';

class ChoiceChipWidget extends StatefulWidget {
  const ChoiceChipWidget({
    Key? key,
    required this.choices,
    required this.index,
  }) : super(key: key);
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
      labelStyle: choiceIndex != null
          ? Monsterats_600_13_FONT_SIZE_WHITE
          : Monsterats_600_13_FONT_SIZE_BLACK,
      onSelected: (isSelected) {
        setState(() {
          if (isSelected) {
            choiceIndex = widget.index;
            BlocProvider.of<SurveyCubit>(context)
                .change_chosen(widget.choices[widget.index]);
            BlocProvider.of<SurveyCubit>(context).is_category_filter = true;
            BlocProvider.of<SurveyCubit>(context).fetch_surveys_stream_category(
                widget.choices[widget.index],
                BlocProvider.of<AuthBloc>(context).state.token);
          } else {
            BlocProvider.of<SurveyCubit>(context).is_category_filter = false;
            BlocProvider.of<SurveyCubit>(context)
                .change_chosen("");
            choiceIndex = null;
            BlocProvider.of<SurveyCubit>(context).fetch_surveys_stream(
                BlocProvider.of<AuthBloc>(context).state.token);
          }
        });
      },
    );
  }
}
