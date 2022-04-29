import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey/logic/bloc/auth_bloc.dart';

class ProfileIcon extends StatelessWidget {
  ProfileIcon({
    Key? key,
    this.is_settings = false,
  }) : super(key: key);
  bool is_settings;

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return is_settings
        ? Container(
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
        : image == null || image.isEmpty
            ? Center(
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
              )
            : Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white10,
                  radius: 110,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      imageUrl: image,
                      fit: BoxFit.cover,
                      height: 300,
                      width: 290,
                    ),
                  ),
                ),
              );
  }
}
