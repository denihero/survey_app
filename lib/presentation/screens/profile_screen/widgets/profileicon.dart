import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  ProfileIcon({
    Key? key,
    this.is_settings = false,
  }) : super(key: key);
  bool is_settings;

  @override
  Widget build(BuildContext context) {
    return is_settings?
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 4,
              ),
            ]),
        padding: EdgeInsets.all(is_settings ? 20 : 50),
        child: Icon(
          Icons.person,
          size: is_settings ? 43 : 100,
        ),
      )
      :
    Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 4,
              ),
            ]),
        padding: EdgeInsets.all(is_settings ? 20 : 50),
        child: Icon(
          Icons.person,
          size: is_settings ? 43 : 100,
        ),
      ),
    );
  }
}
