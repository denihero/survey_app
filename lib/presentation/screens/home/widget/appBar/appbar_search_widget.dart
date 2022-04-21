
import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/models/survey.dart';
import 'package:survey/logic/bloc/login_api.dart';


class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

 final List<Surveys> _fountItems = [];
  late List<Surveys> _postDisplay = [];
 @override
  void initState() {
   setState(() {
     get_surveys().then((value) {
       _fountItems.addAll(value);
     });
     _postDisplay = _fountItems;
   });
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        cursorHeight: 20,
        style: const TextStyle(
            fontSize: 17
        ),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _postDisplay = _fountItems.where((post) {
              var postTitle = post.title?.toLowerCase();
              return postTitle!.contains(text);
            }).toList();


          });

        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 2,left: 10),
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
          hintStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black
          ),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

