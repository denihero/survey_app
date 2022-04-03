import 'package:flutter/material.dart';
import 'package:survey/core/constants/style.dart';

class UserSurveyCard extends StatefulWidget {
  const UserSurveyCard({Key? key,required this.title,required this.count}) : super(key: key);
  final String title;
  final int count;


  @override
  State<UserSurveyCard> createState() => _UserSurveyCardState();
}
class _UserSurveyCardState extends State<UserSurveyCard> {
  bool? isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: const FittedBox(child: Placeholder()),
          title: Text(widget.title,style: Monsterats_500_15_FONT_SIZE_BLACK,),
          subtitle: Text('Survey: ${widget.count}',style: Monsterats_500_15_FONT_SIZE_BLACK,),
          trailing: IconButton(
            icon:const Icon(Icons.favorite),
            color: isSaved! ? Colors.black : Colors.grey,
            onPressed: () {
              setState(() {
                if(!isSaved!){
                  isSaved = true;
                }else {
                  isSaved = false;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
