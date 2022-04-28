import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';
import 'package:survey/logic/bloc/login_api.dart';
import 'package:survey/logic/cubit/survey_cubit.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  void searchSurvey(String query) {
    var surveys = BlocProvider.of<SurveyCubit>(context).state.surveys;
    var surv = surveys.where((surveys) {
      final titleLower = surveys.title?.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower);
    }).toList();
    surv;
    setState(() {
      surv;
    });
  }

  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        cursorHeight: 20,
        controller: controller,
        style: const TextStyle(fontSize: 17),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (text) async {
          searchSurvey(text);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 2, left: 10),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(color: Colors.transparent)),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.5),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: CircleAvatar(
                radius: 10,
                backgroundColor: BLUE,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: WHITE,
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    BlocProvider.of<SurveyCubit>(context).is_category_filter = true;
                    BlocProvider.of<SurveyCubit>(context).find(
                        controller.text, BlocProvider.of<AuthBloc>(context).state.token);
                  },
                )),
          ),
          hintStyle: const TextStyle(fontSize: 15, color: Colors.black),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
