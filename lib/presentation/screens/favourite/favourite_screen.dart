import 'package:flutter/material.dart';

import '../favourite/widget/card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
      child: Column(
        children: [
          //Title
          const Center(
            child: Text(
              "Saved",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
          ),
          const SizedBox(
            height: 120,
          ),
          Expanded(
            child: ListView(
              // Saved Cards
              children: const [
                InfoCard(
                    title: "Math for high school",
                    subtitle: "0/35 Questions",
                    isSaved: true),
                InfoCard(
                    title: "Math for high school",
                    subtitle: "0/35 Questions",
                    isSaved: true),
                InfoCard(
                    title: "Math for high school",
                    subtitle: "0/35 Questions",
                    isSaved: true),
                InfoCard(
                    title: "Math for high school",
                    subtitle: "0/35 Questions",
                    isSaved: true),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
