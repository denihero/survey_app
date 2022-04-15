import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/cubit/categories_cubit.dart';
import 'package:survey/presentation/screens/home/widget/choice_chip_widget.dart';

import '../../../../logic/bloc/login_api.dart';

class CategoryChooseWidget extends StatefulWidget {
  const CategoryChooseWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<CategoryChooseWidget> createState() => _CategoryChooseState();
}

class _CategoryChooseState extends State<CategoryChooseWidget> {
  var _choices = <String>[];
  @override
  Widget build(BuildContext context) {
    print(_choices);
    return BlocBuilder<CategoriesCubit, Categoriess>(
      builder: (context, state) {
      _choices = state.categories;
        return SizedBox(
          height: MediaQuery.of(context).size.height / 13,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _choices.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ChoiceChipWidget(
                      choices: _choices,
                      index: index,
                    ));
              }),
        );
      },
    );
  }
}
