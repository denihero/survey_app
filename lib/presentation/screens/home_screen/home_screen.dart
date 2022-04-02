import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/home_screen/widget/appbar_with_search.dart';
import 'package:survey/presentation/screens/home_screen/widget/card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.7,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(27),
                  bottomRight: Radius.circular(27),
                ),
              ),
              child: Column(
                children: const [
                  //title
                  Center(
                    child: Text(
                      "Survey App",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Search(),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Results:",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: const [
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: false),
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: true),
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: false),
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: true),
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: true),
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: false),
                      InfoCard(
                          title: "Math for high school",
                          subtitle: "0/35 questions",
                          isSaved: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
