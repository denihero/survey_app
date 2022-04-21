import 'package:flutter/material.dart';
import 'package:survey/presentation/screens/profile/widgets/profileicon.dart';


class ProfileEditIcon extends StatelessWidget {
  const ProfileEditIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Stack(
        // alignment: Alignment.bottomRight,
        clipBehavior: Clip.hardEdge, children: [
          ProfileIcon(
            is_settings: true,
          ),
          Positioned(
              left: 50,
              top: 40,
              child: Container(
                padding: const EdgeInsets.all(7),
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
                child: const Icon(
                  Icons.edit,
                  size: 26,
                ),
              )),
        ],
      ),
    );
  }
}
