import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';


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
                        left: 20,
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'admin',
        onPressed: () {  },
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
