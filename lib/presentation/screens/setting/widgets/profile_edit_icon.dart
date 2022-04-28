import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/presentation/screens/profile/widgets/profileicon.dart';

import '../../../../logic/bloc/auth_bloc.dart';

class ProfileEditIcon extends StatelessWidget {
  const ProfileEditIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return SizedBox(
      width: 150,
      child: Stack(
        // alignment: Alignment.bottomRight,
        clipBehavior: Clip.hardEdge,
        children: [
          image==null?
          ProfileIcon(
            is_settings: true,
          ):
          CircleAvatar(
            radius: 43,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: image ,
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
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
