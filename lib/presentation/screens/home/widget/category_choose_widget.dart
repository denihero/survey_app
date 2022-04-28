import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/style.dart';
import '../../../../logic/bloc/auth_bloc.dart';
import '../../../../logic/cubit/survey_cubit.dart';




class CategoryChooseWidget extends StatefulWidget {
  const CategoryChooseWidget({Key? key}) : super(key: key);

  @override
  State<CategoryChooseWidget> createState() => _CategoryChooseWidgetState();
}

class _CategoryChooseWidgetState extends State<CategoryChooseWidget> {
  int? choiceIndex;
  var _choices = <String>[];
  @override
  Widget build(BuildContext context) {
    log('$_choices');
    return BlocBuilder<CategoriesCubit, Cat>(
      builder: (context, state) {
        _choices = state.categories.keys.toList();
        return SizedBox(
          height: MediaQuery.of(context).size.height / 13,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _choices.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Wrap(
                      spacing: 10,
                      children: techChips(index),
                    )
                );
              }),
        );
      },
    );
  }

  List<Widget> techChips(int index) {
    List<Widget> chips = [];
    for(int i = 0;i < _choices.length;i++){
      Widget item = ChoiceChip(
        label: Text(
          _choices[i],
        ),
        backgroundColor: WHITE,
        selectedColor: ORANGE,
        selected: choiceIndex == i,
        elevation: 5,
        shadowColor: BLACK,
        labelStyle: choiceIndex == i
            ? Monsterats_600_13_FONT_SIZE_WHITE
            : Monsterats_600_13_FONT_SIZE_BLACK,
        onSelected: (isSelected){
         setState((){
           if(isSelected){
             choiceIndex = i;
             BlocProvider.of<SurveyCubit>(context)
                 .change_chosen(_choices[i]);
             BlocProvider.of<SurveyCubit>(context).is_category_filter = true;
             BlocProvider.of<SurveyCubit>(context).fetch_surveys_stream_category(
                 _choices[i],
                 BlocProvider.of<AuthBloc>(context).state.token);
           }else{
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
      chips.add(item);
    }
    return chips;
  }
}

