import 'package:flutter/material.dart';

import 'package:survey/presentation/screens/pre_quiz_screen/widget/title.dart';


class PreQuizScreen extends StatelessWidget {
  const PreQuizScreen({Key? key, required this.title, required this.description}) : super(key: key);
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              //kinda appbar
              TitleWidget(
                title: title,
                icon: Icons.home,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                title,
                // ignore: unnecessary_const
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 50,
              ),


              //description of the course
              Expanded(
                child: ListView(children: [
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  //button
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(9)),
                    child: const Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
