import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.isSaved})
      : super(key: key);

  final String title;
  final String subtitle;
  final bool isSaved;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const FittedBox(child: Placeholder()),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.favorite,
          color: isSaved ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
