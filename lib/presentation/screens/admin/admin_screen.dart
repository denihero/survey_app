import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';


class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10,left: 10),
          child: BackButton(
            color: BLACK,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: BLUE,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),

                    const Positioned(
                        top: 40,
                        left: 25,
                        child: Text(
                            'Upload Image',
                            style: TextStyle(
                                fontSize: 14,
                                color:WHITE
                            ),
                        ))
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Type title'
                          ),

                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Type Description'
                          ),

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:  EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.09,
                  left: MediaQuery.of(context).size.width * 0.03
                ),
                child: Text(
                    'Your questions:',
                    style: Monsterats_600_24_FONT_SIZE_BLACK ,
                ),
              ),
            )
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'admin',
        onPressed: () => Navigator.pushNamed(context, '/create_question'),
        label: Row(
          children: const [
            Icon(Icons.add),
            Text('Add Question')

          ],
        ),

      ),
    );
  }
}
