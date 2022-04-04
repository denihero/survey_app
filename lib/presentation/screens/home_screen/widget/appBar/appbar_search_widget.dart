import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/presentation/screens/home_screen/widget/appbar_search.dart

import '../../../../core/constants/color.dart';
=======
import 'package:survey/core/constants/color.dart';
>>>>>>> 6ae20db9bba80b0090e85f761776bc76fc48e0eb:lib/presentation/screens/home_screen/widget/appBar/appbar_search_widget.dart


class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: Colors.transparent)
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(color: Colors.transparent)
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.5),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: CircleAvatar(
                radius: 10,
                backgroundColor: BLUE,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: WHITE,onPressed: () {}
                  ,)
            ),
          ),
          labelText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
