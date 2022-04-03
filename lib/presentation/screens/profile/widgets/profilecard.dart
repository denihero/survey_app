import 'package:flutter/material.dart';
import '../../../../core/constants/style.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 15, left: 3, right: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const FittedBox(child: Placeholder()),
          title: Text(
            title,
            style: Monsterats_500_15_FONT_SIZE_BLACK.copyWith(fontSize: 14.3),
          ),
          subtitle: Text(
            subtitle,
            style: Monsterats_500_15_FONT_SIZE_BLACK,
          ),
        ),
      ),
    );
  }
}
