import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';


class CreateQuestionScreen extends StatelessWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: BackButton(
            color: BLACK,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
             Align(
               alignment: Alignment.topLeft,
               child: Padding(
                 padding: EdgeInsets.only(
                   top: MediaQuery.of(context).size.width * 0.07,
                   left: MediaQuery.of(context).size.width * 0.06,
                   bottom: MediaQuery.of(context).size.width * 0.03,
                 ),
                 child: Text(
                    'Write your questions',
                    style: Monsterats_500_18_FONT_SIZE_BLACK,
            ),
               ),
             ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                textCapitalization: TextCapitalization.sentences,
                cursorHeight: 20,
                style: const TextStyle(
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  hintText: 'Question',
                  hintStyle: const TextStyle(
                    fontSize: 16
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.09,
                  left: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Text(
                  'Possible Answer',
                  style: Monsterats_500_18_FONT_SIZE_BLACK,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.020,
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  textCapitalization: TextCapitalization.sentences,
                  cursorHeight: 20,
                  style: const TextStyle(
                      fontSize: 16
                  ),
                  decoration: InputDecoration(
                    hintText: 'Answer',
                    hintStyle: const TextStyle(
                        fontSize: 16
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        )
      ),
    );
  }
}
