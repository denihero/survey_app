import 'package:flutter/material.dart';
import 'package:survey/core/constants/color.dart';
import 'package:survey/core/constants/style.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Card(
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          color: BLUE,
          child: ListTile(
            leading: const CircleAvatar(
              radius: 20,
              backgroundColor: ORANGE,
            ),
            title: Text(
              'username',
              style: Monsterats_500_16_FONT_SIZE_WHITE,
            ),
            trailing: SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: WHITE,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
